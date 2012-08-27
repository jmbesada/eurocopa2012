package groovy

class Sample {

	Integer a;
	
	def doSomething(String... list){
		println list
	}
	
	Sample plus (Sample obj){
		return new Sample(a:(this.a+obj.a))
	}
	
	Sample plus (Integer a){
		return new Sample(a:(this.a+a))
	}
	
	String toString(){
		return a
	}
}

new Sample(a:2).doSomething '1','2'

println (new Sample(a:5)+3)

println (new Sample(a:5)+new Sample(a:5))
