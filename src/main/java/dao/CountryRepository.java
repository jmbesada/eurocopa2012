package dao;

import java.util.List;

import org.springframework.data.repository.CrudRepository;

import domain.Country;

public interface CountryRepository extends CrudRepository<Country, Long> {

	List<Country> findByGroup_Name(String groupName);
	
	List<Country> findByGroup_NameOrderByClassificationAsc(String groupName);
	
	List<Country> findByQualified(Boolean qualified);
	
	Country findByName(String name);
}
