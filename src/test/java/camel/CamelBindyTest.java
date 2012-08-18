package camel;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.camel.CamelContext;
import org.apache.camel.dataformat.bindy.csv.BindyCsvDataFormat;
import org.apache.camel.impl.DefaultCamelContext;
import org.apache.camel.impl.DefaultExchange;
import org.apache.camel.spi.DataFormat;
import org.junit.Test;

import domain.Country;
import domain.Group;

public class CamelBindyTest {

	@Test
	public void testSerializeToCsv() throws Exception{
		List<Map<String, Object>> models = new ArrayList<Map<String, Object>>();
		Map<String, Object> model = new HashMap<String, Object>();
		CamelContext context=new DefaultCamelContext();
		BindyCsvDataFormat bindy = new BindyCsvDataFormat("domain");
		Group group=new Group();
		group.setName("A");
		group.setId(2l);
		Country country=new Country();
		country.setGroup(group);
		country.setName("Austria");
		country.setClassification(10);
		country.setIconPath("/path");
		country.setQualified(true);
		country.setId(1l);
		model.put(group.getClass().getName(), group);
		model.put(country.getClass().getName(), country);
		models.add(model);
		bindy.marshal(new DefaultExchange(context), models, System.out);
	}
}
