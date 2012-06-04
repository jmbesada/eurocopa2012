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
import org.springframework.mail.SimpleMailMessage;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.stereotype.Controller;
import org.springframework.ui.velocity.VelocityEngineUtils;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import dao.UserRepository;

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
		Object mailSender=context.getBean("mailSender");
		if (mailSender instanceof JavaMailSender){
			SimpleMailMessage message=new SimpleMailMessage();
			message.setSubject("Nueva sugerencia de "+Helper.getSessionUsername());
			message.setFrom("jmbesada@qwi-ti.com");
			message.setText(hint);
			message.setTo("jmbesada@qwi.es");
			((JavaMailSender) mailSender).send(message);
			logger.info("Main sent");
		}
		else if(mailSender instanceof EmailSender){
			Map<String,String> model=new HashMap<String,String>();
			model.put("hint", hint);
			model.put("basePath", "http://eurocopa2012.cloudfoundry.com");
			model.put("username", Helper.getSessionUsername());
			String text=VelocityEngineUtils.mergeTemplateIntoString(velocity, "hintTemplate.html", model);
			((EmailSender) mailSender).sendHint(text,Helper.getSessionUsername());
		}
	}
	
	
}
