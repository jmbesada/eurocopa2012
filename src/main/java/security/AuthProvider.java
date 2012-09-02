package security;

import java.util.Arrays;

import org.jboss.logging.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.authority.SimpleGrantedAuthority;
import org.springframework.security.core.userdetails.User;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.core.userdetails.UsernameNotFoundException;

import dao.UserRepository;

public class AuthProvider implements UserDetailsService{

	@Autowired private UserRepository userRepository;
	
	
	@Override
	public UserDetails loadUserByUsername(String username)
			throws UsernameNotFoundException {
		GrantedAuthority[] authorities=new GrantedAuthority[]{new SimpleGrantedAuthority("ROLE_USER")};
		domain.User user=userRepository.findByEmail(username);
		if (user!=null){
			return new User(username,user.getPassword(),Arrays.asList(authorities));
		}
		else{
			return null;
		}
	
	}

}
