package fastjson;

import javax.persistence.Transient;

import org.junit.Test;

import com.alibaba.fastjson.JSON;
import com.alibaba.fastjson.annotation.JSONField;
import com.alibaba.fastjson.annotation.JSONType;
import com.alibaba.fastjson.serializer.SimplePropertyPreFilter;

public class TestSimplePropertyPreFilter {

	public static class VO {

		private int id;
		
		private String name;

		public int getId() {
			return id;
		}

		public void setId(int id) {
			this.id = id;
		}
		
		public String getName() {
			return name;
		}
		
		public void setName(String name) {
			this.name = name;
		}
		
	}

	@Test
	public void test() {

		VO vo = new VO();

		vo.setId(123);
		vo.setName("flym");

		SimplePropertyPreFilter filter = new SimplePropertyPreFilter(VO.class);
//		filter.getExcludes().add("name");
		System.out.println(
				JSON.toJSONString(vo, filter));
		String s = "{\"id\":123,\"name\":\"flym\"}";
		VO v = JSON.parseObject(s, VO.class);
		System.out.println(v.getName());
	}

}
