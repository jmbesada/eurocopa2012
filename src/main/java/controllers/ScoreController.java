package controllers;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
@RequestMapping("/score/*")
public class ScoreController {

	@RequestMapping("index")
	public void index(){
		
	}
}
