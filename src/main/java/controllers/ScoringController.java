package controllers;

import java.util.Date;
import java.util.List;
import java.util.TreeSet;

import org.jboss.logging.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.transaction.TransactionStatus;
import org.springframework.transaction.support.TransactionCallback;
import org.springframework.transaction.support.TransactionTemplate;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import dao.CountryRepository;
import dao.UserRepository;
import domain.Bet;
import domain.Country;
import domain.User;
import dto.UserDetailDTO;

@Controller
@RequestMapping("/scoring/*")
public class ScoringController {

	@Autowired UserRepository userRepository;
	@Autowired CountryRepository countryRepository;
	@Autowired TransactionTemplate txTemplate;
	private Logger logger=Logger.getLogger(ScoringController.class);
	
	@RequestMapping("index")
	public void index(final Model model){
		txTemplate.execute(new TransactionCallback<Void>(){

			@Override
			public Void doInTransaction(TransactionStatus arg0) {
				Iterable<User> users=userRepository.findAll();
				TreeSet<User> orderedList=new TreeSet<User>();
				for (User user:users){
					//logger.info(user.getBets());
					if (user.getBets().size()>0){
						calculateScoring(user);
						orderedList.add(user);
					}
					
				}
				model.addAttribute("users",orderedList);
				return null;
			}
			
		});
	
	}
	
	@RequestMapping("groupsScoring")
	public void groupsScoring(Model model){
		model.addAttribute("now", new Date());
		model.addAttribute("groupA",countryRepository.findByGroup_NameOrderByClassificationAsc("Grupo A"));
		model.addAttribute("groupB",countryRepository.findByGroup_NameOrderByClassificationAsc("Grupo B"));
		model.addAttribute("groupC",countryRepository.findByGroup_NameOrderByClassificationAsc("Grupo C"));
		model.addAttribute("groupD",countryRepository.findByGroup_NameOrderByClassificationAsc("Grupo D"));
	}
	
	@RequestMapping("userDetail")
	@ResponseBody
	public UserDetailDTO userDetail(@RequestParam("username") String username){
		List<Country> groupA=countryRepository.findByGroup_NameOrderByClassificationAsc("Grupo A");
		List<Country> groupB=countryRepository.findByGroup_NameOrderByClassificationAsc("Grupo B");
		List<Country> groupC=countryRepository.findByGroup_NameOrderByClassificationAsc("Grupo C");
		List<Country> groupD=countryRepository.findByGroup_NameOrderByClassificationAsc("Grupo D");
		User user=userRepository.findByEmail(username);
		UserDetailDTO dto=new UserDetailDTO();
		dto.setFirstLevelScoring(calculateScoringFirstLevel(groupA, user.getBets())+
				calculateScoringFirstLevel(groupB, user.getBets())+calculateScoringFirstLevel(groupC, user.getBets())+
				calculateScoringFirstLevel(groupD, user.getBets()));
		dto.setSecondLevelScoring(calculateScoringSecondLevel(groupA, user.getBets())+
				calculateScoringSecondLevel(groupB, user.getBets())+calculateScoringSecondLevel(groupC, user.getBets())+
				calculateScoringSecondLevel(groupD, user.getBets()));
		int thirdLevelScoring=0;
		if (calculateScoringFirstLevel(groupA, user.getBets()) == 0 && calculateScoringSecondLevel(groupA, user.getBets()) ==0){
			thirdLevelScoring+=calculateScoringThirdLevel(groupA, user.getBets());
		}
		if (calculateScoringFirstLevel(groupB, user.getBets()) == 0 && calculateScoringSecondLevel(groupB, user.getBets()) ==0){
			thirdLevelScoring+=calculateScoringThirdLevel(groupB, user.getBets());
		}
		if (calculateScoringFirstLevel(groupC, user.getBets()) == 0 && calculateScoringSecondLevel(groupC, user.getBets()) ==0){
			thirdLevelScoring+=calculateScoringThirdLevel(groupC, user.getBets());
		}
		if (calculateScoringFirstLevel(groupD, user.getBets()) == 0 && calculateScoringSecondLevel(groupD, user.getBets()) ==0){
			thirdLevelScoring+=calculateScoringThirdLevel(groupD, user.getBets());
		}
		dto.setThirdLevelScoring(thirdLevelScoring);
		dto.setFourthLevelScoring(calculateScoringFourthLevel(groupA, user.getBets())+
				calculateScoringFourthLevel(groupB, user.getBets())+calculateScoringFourthLevel(groupC, user.getBets())+
				calculateScoringFourthLevel(groupD, user.getBets()));
		return dto;
	}
	
	private void calculateScoring(User user){
		List<Country> groupA=countryRepository.findByGroup_NameOrderByClassificationAsc("Grupo A");
		List<Country> groupB=countryRepository.findByGroup_NameOrderByClassificationAsc("Grupo B");
		List<Country> groupC=countryRepository.findByGroup_NameOrderByClassificationAsc("Grupo C");
		List<Country> groupD=countryRepository.findByGroup_NameOrderByClassificationAsc("Grupo D");
		
		//Group A's score
		double scoreA=calculateScoringFirstLevel(groupA, user.getBets());
		double auxScoreA=calculateScoringFourthLevel(groupA, user.getBets());
		if (scoreA == 0) scoreA+=calculateScoringSecondLevel(groupA, user.getBets());
		if (scoreA == 0) scoreA+=calculateScoringThirdLevel(groupA, user.getBets());
		logger.info("User "+user.getEmail()+" has got "+scoreA+" in the groupA");
		
		//Group B's score
		double scoreB=calculateScoringFirstLevel(groupB, user.getBets());
		double auxScoreB=calculateScoringFourthLevel(groupB, user.getBets());
		if (scoreB == 0) scoreB+=calculateScoringSecondLevel(groupB, user.getBets());
		if (scoreB == 0) scoreB+=calculateScoringThirdLevel(groupB, user.getBets());
		logger.info("User "+user.getEmail()+" has got "+scoreB+" in the groupB");
		
		//Group C's score
		double scoreC=calculateScoringFirstLevel(groupC, user.getBets());
		double auxScoreC=calculateScoringFourthLevel(groupC, user.getBets());
		if (scoreC == 0) scoreC+=calculateScoringSecondLevel(groupC, user.getBets());
		if (scoreC == 0) scoreC+=calculateScoringThirdLevel(groupC, user.getBets());
		logger.info("User "+user.getEmail()+" has got "+scoreC+" in the groupC");
		
		//Group D's score
		double scoreD=calculateScoringFirstLevel(groupD, user.getBets());
		double auxScoreD=calculateScoringFourthLevel(groupD, user.getBets());
		if (scoreD == 0) scoreD+=calculateScoringSecondLevel(groupD, user.getBets());
		if (scoreD == 0) scoreD+=calculateScoringThirdLevel(groupD, user.getBets());
		logger.info("User "+user.getEmail()+" has got "+scoreD+" in the groupD");
		
		//Calculate total score
		user.setScoring(scoreA+scoreB+scoreC+scoreD+auxScoreA+auxScoreB+auxScoreC+auxScoreD);
		user.setAuxScoring(auxScoreA+auxScoreB+auxScoreC+auxScoreD);
	}
	
	private Integer calculateScoringFirstLevel(List<Country> groupCountries,List<Bet> bets){
		int score=4;
		Country firstCountry=groupCountries.get(0);
		Country secondCountry=groupCountries.get(1);
		for (Bet bet:bets){
			if (bet.getCountry().equals(firstCountry)){
				//logger.info("----->"+bet.getCountry()+";"+bet.getPosition());
				if (bet.getPosition() != 1) {
					score=0;
					break;
				}
			}
			else if(bet.getCountry().equals(secondCountry)){
				//logger.info("----->"+bet.getCountry()+";"+bet.getPosition());
				if (bet.getPosition() != 2){
					score=0;
					break;
				}
				
			}
		}
		return score;
	}
	
	private Integer calculateScoringSecondLevel(List<Country> groupCountries,List<Bet> bets){
		int score=3;
		Country firstCountry=groupCountries.get(0);
		Country secondCountry=groupCountries.get(1);
		for (Bet bet:bets){
			if (bet.getCountry().equals(firstCountry)){
				if (bet.getPosition() != 2) {
					score=0;
					break;
				}
			}
			else if(bet.getCountry().equals(secondCountry)){
				if (bet.getPosition() != 1){
					score=0;
					break;
				}
			}
		}
		return score;
	}
	
	private Integer calculateScoringThirdLevel(List<Country> groupCountries,List<Bet> bets){
		int score=0;
		Country firstCountry=groupCountries.get(0);
		Country secondCountry=groupCountries.get(1);
		for (Bet bet:bets){
			if (bet.getCountry().equals(firstCountry)){
				if (bet.getPosition() == 2 || bet.getPosition() == 1) {
					score=2;
					break;
				}
			}
			else if(bet.getCountry().equals(secondCountry)){
					if (bet.getPosition() == 2 || bet.getPosition() == 1) {
						score=2;
						break;
					}
			}
		}
		return score;
	}
	
	private Integer calculateScoringFourthLevel(List<Country> groupCountries,List<Bet> bets){
		int score=0;
		Country firstCountry=groupCountries.get(0);
		Country secondCountry=groupCountries.get(1);
		Country thirdCountry=groupCountries.get(2);
		Country fourthCountry=groupCountries.get(3);
		for (Bet bet:bets){
			if (bet.getCountry().equals(firstCountry)){
				if (firstCountry.getClassification() == bet.getPosition()) {
					score+=1;
				}
			}
			else if (bet.getCountry().equals(secondCountry)){
				if (secondCountry.getClassification() == bet.getPosition()) {
					score+=1;
				}
			}
			else if (bet.getCountry().equals(thirdCountry)){
				if (thirdCountry.getClassification() == bet.getPosition()) {
					score+=1;
				}
			}
			else if (bet.getCountry().equals(fourthCountry)){
				if (fourthCountry.getClassification() == bet.getPosition()) {
					score+=1;
				}
			}
			
		}
		return score;
	}
	
}
