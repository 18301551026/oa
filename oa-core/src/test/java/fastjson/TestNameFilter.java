package fastjson;

import java.util.HashMap;
import java.util.Map;

import org.junit.Assert;
import org.junit.Test;

import com.alibaba.fastjson.serializer.JSONSerializer;
import com.alibaba.fastjson.serializer.NameFilter;
import com.alibaba.fastjson.serializer.SerializeWriter;

public class TestNameFilter {

	public void test1() {

		NameFilter filter = new NameFilter() {

			public String process(Object source, String name, Object value) {
				if (name.equals("id")) {
					return "ID";
				}

				return name;
			}

		};

		SerializeWriter out = new SerializeWriter();
		JSONSerializer serializer = new JSONSerializer(out);
		serializer.getNameFilters().add(filter);

		Map<String, Object> map = new HashMap<String, Object>();
		map.put("id", 0);
		serializer.write(map);

		String text = out.toString();
		Assert.assertEquals("{\"ID\":0}", text);
	}

	static class Bean {
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
	public void test2() {

		NameFilter filter = new NameFilter() {

			public String process(Object source, String name, Object value) {
				if (name.equals("id")) {
					return "ID";
				}

				return name;
			}

		};

		SerializeWriter out = new SerializeWriter();
		JSONSerializer serializer = new JSONSerializer(out);
		serializer.getNameFilters().add(filter);

		Bean a = new Bean();
//		a.setName("abc");
		serializer.write(a);

		String text = out.toString();
		System.out.println(text);
		Assert.assertEquals("{\"ID\":0}", text);
	}

}
