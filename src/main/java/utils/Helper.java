package utils;

import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.core.userdetails.User;

public final class Helper {

	private Helper(){
		
	}
	public static String getSessionUsername(){
		User user=(User)SecurityContextHolder.getContext().getAuthentication().getPrincipal();
		return user.getUsername();
	}
}
