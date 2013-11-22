package fastjson;

import org.junit.Assert;
import org.junit.Test;

import com.alibaba.fastjson.JSON;
import com.alibaba.fastjson.annotation.JSONCreator;
import com.alibaba.fastjson.annotation.JSONField;

public class TestJsonCreator2 {
	static class Entity {
	    private final int    id;
	    private final String name;
	    @JSONCreator
	    public static Entity create(@JSONField(name = "id") int id, @JSONField(name = "name") String name) {
	        return new Entity(id, name);
	    }
	    private Entity(int id, String name){
	        this.id = id;
	        this.name = name;
	    }
	    public int getId() {
	        return id;
	    }
	    public String getName() {
	        return name;
	    }
	}
	
	@Test
	public void test_factoryMethod() throws Exception {
	    Entity entity = new Entity(123, "菜姐");
	    String text = JSON.toJSONString(entity);
	 
	    Entity entity2 = JSON.parseObject(text, Entity.class);
	    Assert.assertEquals(entity.getId(), entity2.getId());
	    Assert.assertEquals(entity.getName(), entity2.getName());
	}
}
