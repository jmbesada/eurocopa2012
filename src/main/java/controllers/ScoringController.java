package controllers;

import java.util.List;
import java.util.TreeSet;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import dao.UserRepository;
import domain.User;

@Controller
@RequestMapping("/scoring/*")
public class ScoringController {

	@Autowired 
	private UserRepository userRepository;
	
	@RequestMapping("index")
	public void index(Model model){
		Iterable<User> users=userRepository.findAll();
		TreeSet<User> orderedList=new TreeSet<User>();
		for (User user:users){
			calculateScoring(user);
			orderedList.add(user);
		}
		model.addAttribute("users",users);
	}
	
	private void calculateScoring(User user){
		user.setScoring(0d);
	}
}
