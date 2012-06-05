package utils;

import java.io.IOException;
import java.net.URI;
import java.net.URISyntaxException;

import org.apache.http.HttpResponse;
import org.apache.http.client.ClientProtocolException;
import org.apache.http.client.HttpClient;
import org.apache.http.client.methods.HttpGet;
import org.apache.http.client.methods.HttpPost;
import org.apache.http.client.utils.URIBuilder;
import org.apache.http.impl.client.DefaultHttpClient;
import org.apache.log4j.Logger;
import org.springframework.util.FileCopyUtils;

public class EmailSender {

	private String username;
	private String password;
	private String host;
	private Logger logger=Logger.getLogger(EmailSender.class);
	
	public String getUsername() {
		return username;
	}
	public void setUsername(String username) {
		this.username = username;
	}
	public String getPassword() {
		return password;
	}
	public void setPassword(String password) {
		this.password = password;
	}
	public String getHost() {
		return host;
	}
	public void setHost(String host) {
		this.host = host;
	}
	
	public void sendHint(String html,String from) throws Exception{
		HttpClient client=new DefaultHttpClient();
		URIBuilder builder=new URIBuilder();
		builder.setScheme("https").setHost("sendgrid.com").setPath("/api/mail.send.xml").
			setParameter("to", "jmbesada@qwi-ti.com").
			setParameter("toname","Jose Miguel").
			setParameter("subject", "Nueva sugerencia recibida de "+from).
			setParameter("api_user", "actraiser").
			setParameter("api_key", "525700").
			setParameter("html", html).
			setParameter("from", "jmbesada@qwi-ti.com");
		URI uri=builder.build();
		//logger.info(uri.toString().replace("%25", "%"));
		HttpPost get=new HttpPost(uri.toString().replace("%25", "%"));
		HttpResponse response=client.execute(get);
		logger.info(new String(FileCopyUtils.copyToByteArray(response.getEntity().getContent())));
	}
}
