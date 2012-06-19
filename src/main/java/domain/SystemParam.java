package domain;

import java.util.Date;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Table;

@Entity
@Table(name="T_SYSTEM_PARAM")
public class SystemParam extends AbstractGenericDomainObject {

	private Date lastDayToBet;
	private boolean firstPhaseFinished;

	
	@Column(name="IS_FIRST_PHASE_FINISHED")
	public boolean isFirstPhaseFinished() {
		return firstPhaseFinished;
	}

	public void setFirstPhaseFinished(boolean firstPhaseFinished) {
		this.firstPhaseFinished = firstPhaseFinished;
	}

	@Column(name="LAST_DAY_TO_BET")
	public Date getLastDayToBet() {
		return lastDayToBet;
	}

	public void setLastDayToBet(Date lastDayToBet) {
		this.lastDayToBet = lastDayToBet;
	}
}
