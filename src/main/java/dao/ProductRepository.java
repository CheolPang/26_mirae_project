package dao;

import java.util.ArrayList;

import dto.Product;

public class ProductRepository {
	private ArrayList<Product> listOfProducts = new ArrayList<Product>();
	
	private static ProductRepository instance = new ProductRepository();
	
	public static ProductRepository getInstance() {
		return instance;
	}
	
	public ProductRepository() {
		Product chair = new Product("P1234","시디즈 베이직 오피스 체어",155550);
		chair.setDescription("컴퓨터,사무용의자\r\n"
				+ "/\r\n"
				+ "메쉬등판\r\n"
				+ "/\r\n"
				+ "패브릭좌판\r\n"
				+ "/\r\n"
				+ "[조절]\r\n"
				+ "틸팅\r\n"
				+ ":\r\n"
				+ "가능\r\n"
				+ ",\r\n"
				+ "강도\r\n"
				+ ",\r\n"
				+ "고정\r\n"
				+ "/\r\n"
				+ "좌판\r\n"
				+ ":\r\n"
				+ "높낮이\r\n"
				+ "/\r\n"
				+ "목받침\r\n"
				+ ":\r\n"
				+ "높낮이\r\n"
				+ ",\r\n"
				+ "각도\r\n"
				+ "/\r\n"
				+ "요추받침\r\n"
				+ ":\r\n"
				+ "높낮이\r\n"
				+ ",\r\n"
				+ "깊이\r\n"
				+ "/\r\n"
				+ "[크기]\r\n"
				+ "좌판가로\r\n"
				+ ":\r\n"
				+ "51cm\r\n"
				+ "/\r\n"
				+ "좌판깊이\r\n"
				+ ":\r\n"
				+ "48cm\r\n"
				+ "/\r\n"
				+ "좌판높이\r\n"
				+ ":\r\n"
				+ "42~48cm\r\n"
				+ "/\r\n"
				+ "총높이\r\n"
				+ ":\r\n"
				+ "115~121cm\r\n"
				+ "/ 색상: 다크그레이, 베이지\r\n");
		chair.setCategory("chair");
		chair.setManufacturer("SIDIZ ");
		chair.setUnitsInStock(1000);
		chair.setCondition("New");
		chair.setFilename("P1234.jpg");
		
		Product sofa = new Product("P1235","동서가구 시에라 천연가죽 소파",478670);
		sofa.setDescription("소파\r\n"
				+ "/\r\n"
				+ "4인용\r\n"
				+ "/\r\n"
				+ "[소재]\r\n"
				+ "천연가죽\r\n"
				+ "/\r\n"
				+ "소가죽 종류\r\n"
				+ ":\r\n"
				+ "면피\r\n"
				+ "/\r\n"
				+ "콤비사용\r\n"
				+ "/\r\n"
				+ "내장재\r\n"
				+ ":\r\n"
				+ "스펀지(폼)\r\n"
				+ ",\r\n"
				+ "라텍스\r\n"
				+ ",\r\n"
				+ "솜\r\n"
				+ ",\r\n"
				+ "스프링\r\n"
				+ "/\r\n"
				+ "[크기/색상]\r\n"
				+ "좌방석깊이\r\n"
				+ ":\r\n"
				+ "55cm\r\n"
				+ "/\r\n"
				+ "크기(가로x세로x높이): 270x92x85cm / 색상: 라이트그레이, 그레이, 베이지, 초코브라운, 화이트그레이, 카멜\r\n");
		sofa.setCategory("sofa");
		sofa.setManufacturer("DongSeo ");
		sofa.setUnitsInStock(5000);
		sofa.setCondition("New");
		sofa.setFilename("P1235.jpg");
		
		Product desk = new Product("P1236","데스커 컴퓨터 책상 2.0",175000);
		desk.setDescription("컴퓨터 책상\r\n"
				+ "/\r\n"
				+ "일자형\r\n"
				+ "/\r\n"
				+ "상판두께\r\n"
				+ ":\r\n"
				+ "28mm\r\n"
				+ "/\r\n"
				+ "E0등급\r\n"
				+ "/\r\n"
				+ "[특징]\r\n"
				+ "철제다리\r\n"
				+ "/\r\n"
				+ "기본포함\r\n"
				+ ":\r\n"
				+ "배선선반\r\n"
				+ "/\r\n"
				+ "[크기/색상]\r\n"
				+ "크기(가로x세로x높이): 1600x800x720mm / 색상: 화이트, 메이플, 모던아카시아, 빈티지블랙\r\n"
				+ "라이트그레이, 그레이, 베이지, 초코브라운, 화이트그레이\r\n");
		desk.setCategory("desk");
		desk.setManufacturer("Desker ");
		desk.setUnitsInStock(8000);
		desk.setCondition("New");
		desk.setFilename("P1236.jpg");
		
		listOfProducts.add(chair);
		listOfProducts.add(sofa);
		listOfProducts.add(desk);
	}
	public ArrayList<Product> getAllProducts() {
		return listOfProducts;
	}
	
	public Product getProductById(String productId) {
		Product productById = null;
		for(int i=0; i<listOfProducts.size(); i++) {
			Product product = listOfProducts.get(i);
			if(product != null && product.getProductId() != null && product.getProductId().equals(productId)) {
				productById = product;
				break;
			}
		}
		return productById;
	}
	public void addProduct(Product product) {
		listOfProducts.add(product);
	}
}
