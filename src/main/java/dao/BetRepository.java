package dao;

import java.util.List;

import org.springframework.data.repository.CrudRepository;

import domain.Bet;
import domain.User;

public interface BetRepository extends CrudRepository<Bet, Long> {

	List<Bet> findByUser(User user);
	
}
