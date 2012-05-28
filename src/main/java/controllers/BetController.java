package controllers;

import java.util.Arrays;
import java.util.List;

import org.apache.commons.lang3.StringUtils;
import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.transaction.TransactionStatus;
import org.springframework.transaction.support.TransactionCallback;
import org.springframework.transaction.support.TransactionTemplate;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import utils.Helper;
import dao.BetRepository;
import dao.CountryRepository;
import dao.UserRepository;
import domain.Bet;
import domain.Country;
import domain.User;
import dto.NotificationDTO;

@Controller
@RequestMapping("/bet/*")
public class BetController {
	
	@Autowired BetRepository betRepository;
	@Autowired UserRepository userRepository;
	@Autowired CountryRepository countryRepository;
	@Autowired TransactionTemplate txTemplate;
	
	private Logger logger=Logger.getLogger(BetController.class);

	@RequestMapping("index")
	public void index(Model model){
		User user=userRepository.findByEmail(Helper.getSessionUsername());
		List<Bet> bets=betRepository.findByUser(user);
		List<Country> countriesA=countryRepository.findByGroup_Name("Grupo A");
		List<Country> countriesB=countryRepository.findByGroup_Name("Grupo B");
		List<Country> countriesC=countryRepository.findByGroup_Name("Grupo C");
		List<Country> countriesD=countryRepository.findByGroup_Name("Grupo D");
		List<String> positions=Arrays.asList(new String[]{"Puesto","1","2","3","4"});
		model.addAttribute("bets", bets);
		model.addAttribute("countriesA", countriesA);
		model.addAttribute("countriesB", countriesB);
		model.addAttribute("countriesC", countriesC);
		model.addAttribute("countriesD", countriesD);
		model.addAttribute("positions",positions);
		logger.info("CountriesA:"+countriesA);
	}
	
	@RequestMapping("saveBets")
	@ResponseBody
	public NotificationDTO saveBets(final @RequestParam String bets){
		return txTemplate.execute(new TransactionCallback<NotificationDTO>(){
			@Override
			public NotificationDTO doInTransaction(TransactionStatus arg0) {
				User user=userRepository.findByEmail(Helper.getSessionUsername());
				List<Bet> betList=betRepository.findByUser(user);
				for(Bet bet:betList){
					betRepository.delete(bet);
				}
				NotificationDTO dto=new NotificationDTO();
				dto.setCode(0);
				
				String[] tokens=bets.split(";");
				for (String token:tokens){
					final Bet bet=new Bet();
					long countryId=Long.parseLong(StringUtils.substringBefore(token, ":"));
					int position=Integer.parseInt(StringUtils.substringAfter(token, ":"));
					Country country=countryRepository.findOne(countryId);
					bet.setCountry(country);
					bet.setPosition(position);
					bet.setUser(user);
					betRepository.save(bet);
				}
				return dto;
			}
			
		});
		
		
	}
	
}