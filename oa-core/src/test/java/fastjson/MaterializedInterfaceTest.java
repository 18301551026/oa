package fastjson;

import org.junit.Assert;
import org.junit.Test;

import com.alibaba.fastjson.JSON;

public class MaterializedInterfaceTest {
	public static interface Bean {
		int getId();

		void setId(int value);

		String getName();

		void setName(String value);
	}

	@Test
	public void test_parse() throws Exception {
		String text = "{\"id\":123, \"name\":\"chris\"}";
		Bean bean = JSON.parseObject(text, Bean.class);

		// 按接口调用
		Assert.assertEquals(123, bean.getId());
		Assert.assertEquals("chris", bean.getName());
		bean.setId(234);
		Assert.assertEquals(234, bean.getId());
	}
}
