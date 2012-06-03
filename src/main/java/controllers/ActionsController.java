package controllers;

import java.io.IOException;
import java.net.URISyntaxException;

import javax.servlet.http.HttpServletResponse;

import org.apache.http.client.ClientProtocolException;
import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.ApplicationContext;
import org.springframework.mail.SimpleMailMessage;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import utils.EmailSender;
import utils.Helper;

@Controller
@RequestMapping("/actions/*")
public class ActionsController {

	@Autowired ApplicationContext context;
	private Logger logger=Logger.getLogger(ActionsController.class);
	
	@RequestMapping("sendHint")
	public void sendHint(HttpServletResponse response, 
			@RequestParam("emailText") String emailText) throws Exception{
		Object mailSender=context.getBean("mailSender");
		if (mailSender instanceof JavaMailSender){
			SimpleMailMessage message=new SimpleMailMessage();
			message.setSubject("Nueva sugerencia de "+Helper.getSessionUsername());
			message.setFrom("jmbesada@qwi-ti.com");
			message.setText(emailText);
			message.setTo("jmbesada@qwi.es");
			((JavaMailSender) mailSender).send(message);
			logger.info("Main sent");
		}
		else if(mailSender instanceof EmailSender){
			((EmailSender) mailSender).sendHint(emailText,Helper.getSessionUsername());
		}
	}
}
