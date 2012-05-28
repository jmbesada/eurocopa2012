package controllers;

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

import dao.UserRepository;
import domain.User;

@Controller
@RequestMapping("/scoring/*")
public class ScoringController {

	@Autowired UserRepository userRepository;
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
	
	private void calculateScoring(User user){
		user.setScoring(0d);
	}
}
