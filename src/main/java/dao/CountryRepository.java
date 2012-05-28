package dao;

import java.util.List;

import org.springframework.data.repository.CrudRepository;

import domain.Country;
import domain.Group;

public interface CountryRepository extends CrudRepository<Country, Long> {

	public List<Country> findByGroup_Name(String groupName);
}
