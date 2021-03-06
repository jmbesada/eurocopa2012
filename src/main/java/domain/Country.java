package domain;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.Table;

@Entity
@Table(name="T_COUNTRIES")
public class Country extends AbstractGenericDomainObject {

	private String name;
	private Group group;
	private String iconPath;
	private Integer classification;
	private Integer points;
	private Boolean qualified;

	@Column(name="QUALIFIED")
	public Boolean getQualified() {
		return qualified;
	}

	public void setQualified(Boolean qualified) {
		this.qualified = qualified;
	}

	@Column(name="NAME")
	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	@ManyToOne()
	@JoinColumn(name="GROUP_ID")
	public Group getGroup() {
		return group;
	}

	public void setGroup(Group group) {
		this.group = group;
	}

	@Column(name="ICON_PATH")
	public String getIconPath() {
		return iconPath;
	}

	public void setIconPath(String iconPath) {
		this.iconPath = iconPath;
	}
	
	
	@Column(name="CLASSIFICATION")
	public Integer getClassification() {
		return classification;
	}
	public void setClassification(Integer classification) {
		this.classification = classification;
	}

	@Column(name="POINTS")
	public Integer getPoints() {
		return points;
	}

	public void setPoints(Integer points) {
		this.points = points;
	}
}
