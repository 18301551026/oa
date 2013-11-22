package fastjson;

import java.util.Date;

import org.junit.Assert;
import org.junit.Test;

import com.alibaba.fastjson.serializer.JSONSerializer;
import com.alibaba.fastjson.serializer.SerializeWriter;
import com.alibaba.fastjson.serializer.SerializerFeature;

public class TestUseISO8601DateFormat {

	@Test
	public void test() {

		SerializeWriter out = new SerializeWriter();

		JSONSerializer serializer = new JSONSerializer(out);
		serializer.config(SerializerFeature.UseISO8601DateFormat, true);
		Assert.assertEquals(true,
				serializer.isEnabled(SerializerFeature.UseISO8601DateFormat));
		serializer.write(new Date(1294552193254L));

		Assert.assertEquals("\"2011-01-09T13:49:53.254\"", out.toString());
	}

}
