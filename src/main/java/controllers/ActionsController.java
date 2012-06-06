package controllers;

import java.io.IOException;
import java.net.URISyntaxException;
import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.http.client.ClientProtocolException;
import org.apache.log4j.Logger;
import org.apache.velocity.app.VelocityEngine;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.ApplicationContext;
import org.springframework.mail.MailSender;
import org.springframework.mail.SimpleMailMessage;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.scheduling.annotation.Async;
import org.springframework.stereotype.Controller;
import org.springframework.ui.velocity.VelocityEngineUtils;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import dao.UserRepository;
import domain.User;

import utils.EmailSender;
import utils.Helper;

@Controller
@RequestMapping("/actions/*")
public class ActionsController {

	@Autowired ApplicationContext context;
	@Autowired VelocityEngine velocity;
	@Autowired UserRepository userRepository;
	
	private Logger logger=Logger.getLogger(ActionsController.class);
	
	@RequestMapping("sendHint")
	public void sendHint(HttpServletResponse response, @RequestParam("hint") String hint) throws Exception{
		EmailSender mailSender=context.getBean(EmailSender.class);
		Map<String,String> model=new HashMap<String,String>();
		model.put("hint", hint);
		model.put("basePath", "http://eurocopa2012.cloudfoundry.com");
		model.put("username", Helper.getSessionUsername());
		String text=VelocityEngineUtils.mergeTemplateIntoString(velocity, "hintTemplate.html", model);
		mailSender.sendEmail(text,"Nueva sugerencia recibida de "+Helper.getSessionUsername());
	
			
	}
	
	@RequestMapping("sendPassword")
	public void sendPassword(HttpServletResponse response, @RequestParam("username") String username)
		throws Exception{
		logger.info("Password request:"+username);
		EmailSender mailSender=context.getBean(EmailSender.class);
		User user=userRepository.findByEmail(username);
		if (user!=null){
			mailSender.setTo(username);
			Map<String,String> model=new HashMap<String,String>();
			model.put("password", user.getPassword());
			model.put("basePath", "http://eurocopa2012.cloudfoundry.com");
			String text=VelocityEngineUtils.mergeTemplateIntoString(velocity, "sendPasswordTemplate.html", model);
			mailSender.sendEmail(text,"Petición de contraseña");
		}
		
	}
	
	
}
