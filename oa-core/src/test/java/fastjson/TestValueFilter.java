package fastjson;

import java.util.HashMap;
import java.util.Map;

import org.junit.Assert;
import org.junit.Test;

import com.alibaba.fastjson.serializer.JSONSerializer;
import com.alibaba.fastjson.serializer.SerializeWriter;
import com.alibaba.fastjson.serializer.ValueFilter;

public class TestValueFilter {

	@Test
	public void test() {

		ValueFilter filter = new ValueFilter() {

			public Object process(Object source, String name, Object value) {
				if (name.equals("name")) {
					return null;
				}

				return value;
			}

		};

		SerializeWriter out = new SerializeWriter();
		JSONSerializer serializer = new JSONSerializer(out);
		serializer.getValueFilters().add(filter);

		Map<String, Object> map = new HashMap<String, Object>();
		map.put("name", "AA");
		serializer.write(map);

		String text = out.toString();
		Assert.assertEquals("{}", text);
	}

}
