package domain;

import java.util.List;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.EnumType;
import javax.persistence.Enumerated;
import javax.persistence.FetchType;
import javax.persistence.JoinColumn;
import javax.persistence.OneToMany;
import javax.persistence.OneToOne;
import javax.persistence.Table;
import javax.persistence.Transient;

import enums.Gender;

@Entity
@Table(name="T_USERS")
public class User extends AbstractGenericDomainObject implements Comparable<User>{

	private String email;
	private String password;
	private List<Bet> bets;
	private Double scoring;
	private Double auxScoring;
	private boolean drawed;
	private Gender gender;
	private Boolean qualified;
	private Country selectedCountryFinalPhase;
	private Integer finalPos;
	

	@Column(name="FINAL_POS")
	public Integer getFinalPos() {
		return finalPos;
	}

	public void setFinalPos(Integer finalPos) {
		this.finalPos = finalPos;
	}

	@OneToOne
	@JoinColumn(name="SELECTED_COUNTRY_ID")
	public Country getSelectedCountryFinalPhase() {
		return selectedCountryFinalPhase;
	}

	public void setSelectedCountryFinalPhase(Country selectedCountryFinalPhase) {
		this.selectedCountryFinalPhase = selectedCountryFinalPhase;
	}

	@Column(name="QUALIFIED")
	public Boolean getQualified() {
		return qualified;
	}

	public void setQualified(Boolean qualified) {
		this.qualified = qualified;
	}

	@Column(name="GENDER")
	@Enumerated(EnumType.STRING)
	public Gender getGender() {
		return gender;
	}

	public void setGender(Gender gender) {
		this.gender = gender;
	}

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

	@OneToMany(mappedBy="user",fetch=FetchType.EAGER)
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
		if (result == 0) result=-auxScoring.compareTo(user.getAuxScoring());
		if (result == 0) {
			result=email.compareTo(user.getEmail());
			setDrawed(true);
			user.setDrawed(true);
		}
		return result;
	}

	@Transient
	public Double getAuxScoring() {
		return auxScoring;
	}

	public void setAuxScoring(Double auxScoring) {
		this.auxScoring = auxScoring;
	}

	
	@Transient
	public boolean isDrawed() {
		return drawed;
	}

	public void setDrawed(boolean drawed) {
		this.drawed = drawed;
	}


}
