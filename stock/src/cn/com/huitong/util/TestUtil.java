package cn.com.huitong.util;

import cn.com.huitong.model.News;

public class TestUtil {
	public static void main(String[] args) {
		int i = 124;
		int j = 82;
		for(;i<134;i++){
			String s = News.newsTypeMap.get(""+j);
//			if(i%10 == 0){
//				j++;
//			}
			String sql = "INSERT INTO `news` VALUES ('"+(i)+"', '"+j+"', '"+s+"', '<p>抒发抒发斯蒂芬"+s+i+"</p>', '<p>short抒发抒发斯蒂芬"+s+i+"</p>', 'title"+s+i+"', '2014-02-10 20:23:15', '1', '备注"+s+i+"');";
			System.out.println(sql);
		}
	}
}
