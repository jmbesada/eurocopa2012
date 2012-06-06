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

	private String from;
	private String to;
	private Logger logger=Logger.getLogger(EmailSender.class);

	
	public void sendEmail(String html,String subject) throws Exception{
		HttpClient client=new DefaultHttpClient();
		URIBuilder builder=new URIBuilder();
		builder.setScheme("https").setHost("sendgrid.com").setPath("/api/mail.send.xml").
			setParameter("to", to).
			setParameter("subject", subject).
			setParameter("api_user", "actraiser").
			setParameter("api_key", "525700").
			setParameter("html", html).
			setParameter("from", from);
		URI uri=builder.build();
		//logger.info(uri.toString().replace("%25", "%"));
		HttpPost get=new HttpPost(uri.toString().replace("%25", "%"));
		HttpResponse response=client.execute(get);
		logger.info(new String(FileCopyUtils.copyToByteArray(response.getEntity().getContent())));
	}


	public String getFrom() {
		return from;
	}


	public void setFrom(String from) {
		this.from = from;
	}


	public String getTo() {
		return to;
	}


	public void setTo(String to) {
		this.to = to;
	}
}
