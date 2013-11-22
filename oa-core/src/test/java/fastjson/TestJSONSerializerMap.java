package fastjson;

import java.util.Collections;

import org.junit.Assert;
import org.junit.Test;

import com.alibaba.fastjson.annotation.JSONField;
import com.alibaba.fastjson.serializer.JSONSerializer;
import com.alibaba.fastjson.serializer.JSONSerializerMap;
import com.alibaba.fastjson.serializer.JavaBeanSerializer;

public class TestJSONSerializerMap {
	public static class User {
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
		User user = new User();
		user.setId(123);
		user.setName("毛头");
		 
		JSONSerializerMap mapping = new JSONSerializerMap();
		mapping.put(User.class, new JavaBeanSerializer(User.class, Collections.singletonMap("id", "uid")));
		 
		JSONSerializer serializer = new JSONSerializer(mapping);
		serializer.write(user);
		String jsonString = serializer.toString();
		 
		Assert.assertEquals("{\"uid\":123}", jsonString);		
	}
}
