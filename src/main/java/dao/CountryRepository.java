package dao;

import java.util.List;

import org.springframework.data.repository.CrudRepository;

import domain.Country;
import domain.Group;

public interface CountryRepository extends CrudRepository<Country, Long> {

	public List<Country> findByGroup_Name(String groupName);
	
	public List<Country> findByGroup_NameOrderByClassificationAsc(String groupName);
	
	public List<Country> findByQualified(Boolean qualified);
	
	public Country findByName(String name);
}
