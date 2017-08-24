package junit.test;

import org.junit.Test;

import com.atguigu.util.JedisPoolUtils;

import redis.clients.jedis.Jedis;

public class TestRedis {
	@Test
	public void test(){
		Jedis jedis = JedisPoolUtils.getJedis();
		System.out.println(jedis);
	}
}
