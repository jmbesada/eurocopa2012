package dao;

import java.util.List;

import org.springframework.data.repository.CrudRepository;

import domain.User;

public interface UserRepository extends CrudRepository<User, Long> {

	User findByEmail(String email);
	List<User> findByQualifiedOrderByFinalPosAsc(Boolean qualified);
	
}
