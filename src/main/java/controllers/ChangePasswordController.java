package controllers;

import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.core.userdetails.User;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import utils.Helper;

import dao.UserRepository;
import dto.NotificationDTO;

@Controller
@RequestMapping("/changePassword/*")
public class ChangePasswordController {

	@Autowired UserRepository userRepository;
	
	private Logger logger=Logger.getLogger(ChangePasswordController.class);
	
	@RequestMapping("index")
	public void index(){
		
	}
	
	@RequestMapping("modify")
	@ResponseBody
	public NotificationDTO modify(@RequestParam("newPassword") String newPassword,
			@RequestParam("repeatNewPassword") String repeatNewPassword){
		NotificationDTO dto=new NotificationDTO();
		if (!newPassword.equals(repeatNewPassword)){
			dto.setCode(1);
			dto.setMessage("No coinciden los dos campos");
		}
		else{
			//logger.info(user.getPassword());
			domain.User loggedUser=userRepository.findByEmail(Helper.getSessionUsername());
			loggedUser.setPassword(newPassword);
			userRepository.save(loggedUser);
			dto.setCode(0);
		}
		return dto;
	}
}
