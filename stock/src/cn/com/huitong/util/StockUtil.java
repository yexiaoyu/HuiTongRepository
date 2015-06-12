package cn.com.huitong.util;

import java.net.InetAddress;
import java.net.NetworkInterface;
import java.text.SimpleDateFormat;
import java.util.Arrays;
import java.util.Collection;
import java.util.Date;
import java.util.Enumeration;
import java.util.List;
import java.util.Random;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

import javax.servlet.http.HttpServletRequest;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

public class StockUtil {

	private static SimpleDateFormat ymdhms = new SimpleDateFormat("yyyyMMddHHmmss");

	public static final Logger log = LoggerFactory.getLogger(StockUtil.class);

	public static final Pattern mobilePattern = Pattern
			.compile("^((13[0-9])|(14[5,7])|(15[^4,\\D])|(17[0-9])|(18[0-9]))\\d{8}$");
	public static final Pattern numPattern = Pattern.compile("^[0-9]*$");

	/**
	 * 
	 * @Title: isMobileNO
	 * @Description: 要更加准确的匹配手机号码只匹配11位数字是不够的，比如说就没有以144开始的号码段，
	 *               故先要整清楚现在已经开放了多少个号码段，国家号码段分配如下： 130-139全字段 145,147
	 *               150-153,155-159字段 180-189全字段 那么现在就可以正则匹配测试了
	 * @author: lilsh lilsh@corp.21cn.com
	 * @date: 2013-12-27 上午11:22:05
	 * @param mobile
	 * @return
	 * @return boolean
	 */
	public static boolean isMobileNO(String mobile) {
		if (mobile == null) {
			return false;
		}
		Matcher m = mobilePattern.matcher(mobile);
		return m.matches();
	}
	/**
	 * 把手机号格式化为138****0000
	 * @param mobile
	 * @return
	 */
	public static String mobilePotting(String mobile){
		if(mobile.length()>4) {                         
			mobile = mobile.substring(0, 3)+"****"+mobile.substring(mobile.length()-4,mobile.length());
		}
		return mobile;
	}


	/**
	 * 判断号码是联通，移动，电信中的哪个, 在使用本方法前，请先验证号码的合法性 规则：
	 * 中国移动拥有号码段为:139,138,137,136,135,134
	 * ,147,159,158,157(3G),151,152,150,182(3G),183,188(3G),187(3G);16个号段
	 * 中国联通拥有号码段为:130,131,132,145,155,156(3G),186(3G),185(3G);8个号段
	 * 中国电信拥有号码段为:133,1349,153,189(3G),180(3G),181;6个号码段
	 * 
	 * "pre"	"PROVIDER"

"133"	"电信""153"	"电信""170"	"电信""177"	"电信""180"	"电信""181"	"电信""189"	"电信"

"134"	"移动""135"	"移动""136"	"移动""137"	"移动""138"	"移动""139"	"移动""147"	"移动""150"	"移动""151"	"移动""152"	"移动"
"157"	"移动""158"	"移动""159"	"移动""182"	"移动""183"	"移动""184"	"移动""187"	"移动""188"	"移动"

"130"	"联通""131"	"联通""132"	"联通""145"	"联通""155"	"联通""156"	"联通""176"	"联通""185"	"联通""186"	"联通"

	 * @param mobile要判断的号码
	 * @return 返回相应类型
	 */
	public static int getMobileType(String mobile) {
		if (mobile.startsWith("0") || mobile.startsWith("+860")) {
			mobile = mobile.substring(mobile.indexOf("0") + 1, mobile.length());
		}
		List<String> chinaUnicom = Arrays.asList(new String[] { "130", "131", "132", "145", "155", "156", "176", "185","186" });
		List<String> chinaMobile1 = Arrays.asList(new String[] { "135", "136", "137", "138", "139", "147", "150", "151", "152",
				"157", "158", "159", "182", "183","184","187", "188" });
		List<String> chinaMobile2 = Arrays.asList(new String[] { "1340", "1341", "1342", "1343", "1344", "1345", "1346",
				"1347", "1348" });

		boolean bolChinaUnicom = (chinaUnicom.contains(mobile.substring(0, 3)));
		boolean bolChinaMobile1 = (chinaMobile1.contains(mobile.substring(0, 3)));
		boolean bolChinaMobile2 = (chinaMobile2.contains(mobile.substring(0, 4)));
		int result = 1; // 电信
		if (bolChinaUnicom){
			result = 3;// 联通
		}else if (bolChinaMobile1 || bolChinaMobile2){
			result = 2; // 移动
		}
		return result;
	}

	public static boolean isEmpty(String value){
		if(value==null||"".equals(value.trim())||"null".equals(value.trim())){
			return true;
		}else 
			return false;
	}
	public static boolean isEmpty(Collection<?> list){
		if(list != null && !"".equals(list) && list.size()>0){
			return false;
		}else{
			return true;
		}
	}

	public static boolean isEmptyOrZero(Integer value) {
		if (value == null || value == 0) {
			return true;
		} else
			return false;
	}


	public static boolean isNumber(String num){
		if (num == null) {
			return false;
		}
		Matcher m = numPattern.matcher(num);
		return m.matches();
	}


	public static String getSerialNum() {
		Random r = new Random();
		int num = 10000 + r.nextInt(90000);
		Date d = new Date();
		String s = d.getTime() + "" + num;
		return s;
	}


	//拿请求ip地址， 通过反向代理后，会加ip地址，只有拿第一个ip才是正确的，但不是绝对100%
	public static String getClientIp(HttpServletRequest request) {
		String ip = request.getHeader("x-forwarded-for");
		if (ip == null || ip.length() == 0 || "unknown".equalsIgnoreCase(ip)) {
			ip = request.getHeader("Proxy-Client-IP");
		}
		if (ip == null || ip.length() == 0 || "unknown".equalsIgnoreCase(ip)) {
			ip = request.getHeader("WL-Proxy-Client-IP");
		}
		if (ip == null || ip.length() == 0 || "unknown".equalsIgnoreCase(ip)) {
			ip = request.getRemoteAddr();
		}
		if(ip.split(",").length>1){
			return ip.split(",")[0];
		}else{
			return ip;
		}
	}

	public static String getLocalIp() {
		String ipString = "";
		//根据网卡取本机配置的IP
		Enumeration<NetworkInterface> netInterfaces = null;
		try {
			netInterfaces = NetworkInterface.getNetworkInterfaces();
			while (netInterfaces.hasMoreElements()) {
				NetworkInterface ni = netInterfaces.nextElement();
				Enumeration<InetAddress> ips = ni.getInetAddresses();
				while (ips.hasMoreElements()) {
					String ip = ips.nextElement().getHostAddress();
					if(isIp4Addr(ip) && !"127.0.0.1".equals(ip)){
						ipString =  ipString + "|" + ip;
					}
				}
			}
			log.debug("获取本地ip="+ipString);
			if(ipString!=null && ipString.length()>30){
				ipString = ipString.substring(0, 30);
			}
		} catch (Exception e) {
			log.error("获得本地IP异常",e);
		}
		return ipString;
	}
	public static String getUserAgent(HttpServletRequest request) {
		return request.getHeader("User-Agent");
	} 
	//判断字符串是否为数字
	public static boolean isNumeric(String str)
	{
		Pattern pattern = Pattern.compile("[0-9]*");
		Matcher isNum = pattern.matcher(str);
		if( !isNum.matches() )
		{
			return false;
		}
		return true;
	}

	public static boolean isIp4Addr(String ipAddress)   
	{
		String ip = "([1-9]|[1-9]\\d|1\\d{2}|2[0-4]\\d|25[0-5])(\\.(\\d|[1-9]\\d|1\\d{2}|2[0-4]\\d|25[0-5])){3}";    
		Pattern pattern = Pattern.compile(ip);    
		Matcher matcher = pattern.matcher(ipAddress);    
		return matcher.matches();    
	} 

	/**
	 * 
	 * @Title: 代替 tab符 和 换行符 ，主要用于日志记录时；
	 * @author: lilsh  lilsh@corp.21cn.com 
	 * @date: 2014-9-24 上午11:31:47 
	 * @param content
	 * @return    
	 * @return String
	 */
	public static String replaceTabAndLine(String content){
		if (content != null) {
			char newLineChar = 0x0A;// 换行符ASC码
			content = content.replaceAll(newLineChar + "", " ");// 去掉换行符
			content = content.replaceAll("\n", " "); // 去掉换行符
			content = content.replaceAll("\t", " "); // 去掉 tab符
		}
		return content;
	}


	public static String getRootDomain(HttpServletRequest request) {
		String domain = request != null ? request.getServerName() : "";
		String parts[] = domain.split("\\.");
		return "." + parts[parts.length - 2] + "." + parts[parts.length - 1];
	}

	//流水号格式：tyll800yyyyMMddHHmmss+三位随机码
	public static String buildSerialId(String pre){
		int i = (int)(Math.random()*900)+100;
		return pre+ymdhms.format(new Date())+String.valueOf(i);
	}
	
	//拿请求ip地址， 通过反向代理后，会加ip地址，只有拿第一个ip才是正确的，但不是绝对100%
    public static String getConnectIps(HttpServletRequest request) {
        String ip = request.getHeader("x-forwarded-for");
        if (ip == null || ip.length() == 0 || "unknown".equalsIgnoreCase(ip)) {
            ip = request.getHeader("Proxy-Client-IP");
        }
        if (ip == null || ip.length() == 0 || "unknown".equalsIgnoreCase(ip)) {
            ip = request.getHeader("WL-Proxy-Client-IP");
        }
        if (ip == null || ip.length() == 0 || "unknown".equalsIgnoreCase(ip)) {
            ip = request.getRemoteAddr();
        }
        return ip;
    }
}
