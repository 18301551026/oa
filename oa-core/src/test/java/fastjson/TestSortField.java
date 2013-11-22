package fastjson;

import org.junit.Assert;
import org.junit.Test;

import com.alibaba.fastjson.JSON;
import com.alibaba.fastjson.JSONObject;
import com.alibaba.fastjson.serializer.SerializerFeature;

public class TestSortField {
	class V1 {

		private int f2;
		private int f1;
		private int f4;
		private int f3;
		private int f5;

		public int getF2() {
			return f2;
		}

		public void setF2(int f2) {
			this.f2 = f2;
		}

		public int getF1() {
			return f1;
		}

		public void setF1(int f1) {
			this.f1 = f1;
		}

		public int getF4() {
			return f4;
		}

		public void setF4(int f4) {
			this.f4 = f4;
		}

		public int getF3() {
			return f3;
		}

		public void setF3(int f3) {
			this.f3 = f3;
		}

		public int getF5() {
			return f5;
		}

		public void setF5(int f5) {
			this.f5 = f5;
		}
	}

	@Test
	public void test_1() throws Exception {
		V1 entity = new V1();

		String text = JSON.toJSONString(entity, SerializerFeature.SortField);
		System.out.println(text);

		// 按字段顺序输出
		// {"f1":0,"f2":0,"f3":0,"f4":0,"f5":0}
		Assert.assertEquals("{\"f1\":0,\"f2\":0,\"f3\":0,\"f4\":0,\"f5\":0}",
				text);

		JSONObject object = JSON.parseObject(text);
		text = JSON.toJSONString(object, SerializerFeature.SortField);
		Assert.assertEquals("{\"f1\":0,\"f2\":0,\"f3\":0,\"f4\":0,\"f5\":0}",
				text);
	}
}
