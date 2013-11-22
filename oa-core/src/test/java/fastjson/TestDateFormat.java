package fastjson;

import java.text.SimpleDateFormat;
import java.util.Date;

import junit.framework.TestCase;

import org.junit.Assert;
import org.junit.Test;

import com.alibaba.fastjson.JSON;
import com.alibaba.fastjson.serializer.SerializeConfig;
import com.alibaba.fastjson.serializer.SimpleDateFormatSerializer;

public class TestDateFormat {

	// 定制化mapping
	private static SerializeConfig mapping = new SerializeConfig();
	static {
		mapping.put(Date.class, new SimpleDateFormatSerializer("yyyy-MM-dd"));
	}

	@Test
	public void test_0() throws Exception {
		Date date = new Date();
		String text = JSON.toJSONString(date, mapping);
		Assert.assertEquals(JSON
				.toJSONString(new SimpleDateFormat("yyyy-MM-dd").format(date)),
				text);
	}

}
