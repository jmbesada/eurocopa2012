package domain;

import java.util.List;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.OneToMany;
import javax.persistence.Table;
import javax.persistence.Transient;

@Entity
@Table(name="T_USERS")
public class User extends AbstractGenericDomainObject implements Comparable<User>{

	private String email;
	private String password;
	private List<Bet> bets;
	private Double scoring;

	@Column(name="EMAIL")
	public String getEmail() {
		return email;
	}

	public void setEmail(String email) {
		this.email = email;
	}

	@Column(name="PASSWORD")
	public String getPassword() {
		return password;
	}

	public void setPassword(String password) {
		this.password = password;
	}

	@OneToMany(mappedBy="user")
	public List<Bet> getBets() {
		return bets;
	}

	public void setBets(List<Bet> bets) {
		this.bets = bets;
	}

	@Transient
	public Double getScoring() {
		return scoring;
	}

	public void setScoring(Double scoring) {
		this.scoring = scoring;
	}

	@Override
	public int compareTo(User user) {
		// TODO Auto-generated method stub
		int result=-scoring.compareTo(user.getScoring());
		if (result == 0) result=email.compareTo(user.getEmail());
		return result;
	}
}
