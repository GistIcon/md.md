class Context { 
 
    private String input; 
    private String output; 
 
    public Context(String input) { 
        this.input = input; 
        this.output = "";
    } 
 
    public String getInput() { 
        return input; 
    } 
    public void setInput(String input) { 
        this.input = input; 
    } 
    public String getOutput() { 
        return output; 
    } 
    public void setOutput(String output) { 
        this.output = output; 
    } 
}
 
abstract class Expression {    
    public abstract void interpret(Context context); 
}
 
class AExpression extends Expression { 
    public void interpret(Context context) { 
        System.out.println("a expression"); 
        String input = context.getInput(); 
 
        context.setInput(input.substring(1)); 
        context.setOutput(context.getOutput()+ "1"); 
    } 
 
}
 
class BExpression extends Expression { 
    public void interpret(Context context) { 
        System.out.println("b expression"); 
        String input = context.getInput(); 
 
        context.setInput(input.substring(1)); 
        context.setOutput(context.getOutput()+ "2"); 
    } 
}
 
public class TestInterpreter {
	 public static void main(String[] args) { 
	        String str = "ab"; 
	        Context context = new Context(str); 
 
	        List<Expression> list = new ArrayList<Expression>(); 
	        list.add(new AExpression()); 
	        list.add(new BExpression()); 
 
	        for(Expression ex : list) { 
	            ex.interpret(context); 
 
	        } 
 
	        System.out.println(context.getOutput()); 
	    } 
}
