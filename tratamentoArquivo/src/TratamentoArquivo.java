import java.io.BufferedReader;
import java.io.File;
import java.io.FileReader;
import java.io.IOException;
import java.util.ArrayList;
import javafx.beans.binding.Bindings;

public class TratamentoArquivo {
	public static void main(String[] args) throws IOException {
		String fileName = "C:\\Users\\MATEUS\\Documents\\R\\dados\\generosFinal3.csv";
		BufferedReader in = new BufferedReader(new FileReader(fileName));
		StringBuffer sb = new StringBuffer((int) new File(fileName).length());
	
		String linha = in.readLine();
			
		while( linha != null ) {
		 sb.append(linha +"\n" );
		 linha = in.readLine();
		}
			
		in.close();
		String text = sb.toString();
		ArrayList<String> generos = new ArrayList<String>();
		
		int n = 1228;

		String lines[] = text.split("\n");
		
		for(int i=0; i<n ; i++) {
			lines[i] = lines[i].replace("{","");
			lines[i] = lines[i].replace("}","");
			
			String temp[] = lines[i].split(";");
			String current = temp[0];
			generos.add(temp[0]);
			lines[i] = lines[i].replace(temp[0], generos.indexOf(current)+"");
			
			if(temp[1].contains(",")) {
				String temp2[] = temp[1].split(",");
				for(int j=0; j<temp2.length; j++) {
								
					if(!generos.contains(temp2[j])) 
						generos.add(temp2[j]);				
					
					lines[i] = lines[i].replace(temp2[j], generos.indexOf(temp2[j])+"");
				}
			}else {
				if(!generos.contains(temp[1])&& !temp[1].equals("NULL")) {
					generos.add(temp[1]);
					lines[i] = lines[i].replace(temp[1],generos.indexOf(temp[1])+"");					
				}
				else 
					if(!temp[1].equals("NULL")) 
						lines[i] = lines[i].replace(temp[1],generos.indexOf(temp[1])+"");
			}
		}
		
		System.out.println("Total: "+generos.size());
		int adj[][] = new int[generos.size()][generos.size()];
		for(int i=0; i<n ; i++)
			System.out.println(lines[i]);
		
		for(int i=0; i<n ; i++) {				
			String temp[] = lines[i].split(";");

			if(temp[1].contains(",")) {
				String temp2[] = temp[1].split(",");
				for(int j=0; j<temp2.length; j++) {
						adj[Integer.parseInt(temp[0])][Integer.parseInt(temp2[j])]=1;		
					
				}
			}else { 
					if(!temp[1].equals("NULL")) 
						adj[Integer.parseInt(temp[0])][Integer.parseInt(temp[1])]=1;
			}
		}
		
		for(int i=0; i<7; i++) {
			for(int j=0; j<7; j++) {
				System.out.print(adj[i][j]+ " ");
			}
			System.out.println();
		}
	}
}