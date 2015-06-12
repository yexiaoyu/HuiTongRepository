package cn.com.huitong.util;

import java.text.DateFormat;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Date;
import java.util.HashMap;
import java.util.Map;
import java.util.TimeZone;
import java.util.concurrent.ExecutorService;
import java.util.concurrent.Executors;
import java.util.regex.Pattern;

public class DateUtil {

	public static final SimpleDateFormat MONTH_FORMAT = new SimpleDateFormat("yyyy-MM");
	public static final SimpleDateFormat DATE_FORMAT = new SimpleDateFormat("yyyy-MM-dd");
	public static final SimpleDateFormat DATETIME_FORMAT = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
	public static final SimpleDateFormat FULL_DATETIME_FORMAT = new SimpleDateFormat("yyyyMMddHHmmssSSS");
	public static final SimpleDateFormat MSEC_FORMAT = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss.SSS");
	public static final SimpleDateFormat FULL_DATETIME_FORMAT_2 = new SimpleDateFormat("yyyyMMdd");
	public static final SimpleDateFormat FULL_DATETIME_FORMAT_3 = new SimpleDateFormat("yyMMdd");
	
	public static final String MONTH = "yyyy-MM";
	public static final String DATE = "yyyy-MM-dd";
	public static final String DATETIME = "yyyy-MM-dd HH:mm:ss";
	public static final String FULL_DATETIME = "yyyyMMddHHmmssSSS";
	public static final String MSEC = "yyyy-MM-dd HH:mm:ss.SSS";
	public static final String MDHM_DATETIME = "yyyyMMddHHmmss";

    /** 锁对象 */
    private static final Object LOCKOBJ = new Object();

    /** 存放不同的日期模板格式的sdf的Map */
    private static Map<String, ThreadLocal<SimpleDateFormat>> SDFMAP = new HashMap<String, ThreadLocal<SimpleDateFormat>>();

    /**
     * 返回一个ThreadLocal的sdf,每个线程只会new一次sdf
     * 
     * @param pattern
     * @return
     */
    private static SimpleDateFormat getDateFormat(final String pattern) {
        ThreadLocal<SimpleDateFormat> tl = SDFMAP.get(pattern);
        // 此处的双重判断和同步是为了防止sdfMap这个单例被多次put重复的sdf
        if (tl == null) {
            synchronized (LOCKOBJ) {
                tl = SDFMAP.get(pattern);
                if (tl == null) {
                    // 只有Map中还没有这个pattern的sdf才会生成新的sdf并放入map
                    //System.out.println("put new sdf of pattern " + pattern + " to map");
                    // 这里是关键,使用ThreadLocal<SimpleDateFormat>替代原来直接new SimpleDateFormat
                    tl = new ThreadLocal<SimpleDateFormat>() {
                        @Override
                        protected SimpleDateFormat initialValue() {
                            //System.out.println("thread: " + Thread.currentThread() + " init pattern: " + pattern);
                            return new SimpleDateFormat(pattern);
                        }
                    };
                    SDFMAP.put(pattern, tl);
                }
            }
        }
        return tl.get();
    }
    
    /**
     * @Title: formatNew 
     * @Description: 返回格式化时间
     * @author: lilsh  lilsh@corp.21cn.com 
     * @date: 2014-9-15 下午4:45:35 
     */
	public static String formatNew(Date date, String dateFormat) {
		return getDateFormat(dateFormat).format(date);
	}
	
	 /**
     * @Title: formatNew 
     * @Description: 返回格式化时间
     * @author: lilsh  lilsh@corp.21cn.com 
     * @date: 2014-9-15 下午4:45:35 
     */
	public static String formatNew(Object date, String dateFormat) {
		return getDateFormat(dateFormat).format(date);
	}

	/**
     * @Title: parse 
     * @Description: 返回解析时间
     * @author: lilsh  lilsh@corp.21cn.com 
     * @date: 2014-9-15 下午4:45:35 
     */
	public static Date parse(String strDate, String dateFormat) throws ParseException {
		return getDateFormat(dateFormat).parse(strDate);
	}
	

	/*
	 * 获取当前时间戳,格式:yyyy-MM-dd HH:mm:ss,时区为:东八区(GMT+8)
	 * 
	 * @return
	 */
	public static String getCurrentTimestampStr(String sdf, String tz) {
		DateFormat df = new SimpleDateFormat(sdf);
		df.setTimeZone(TimeZone.getTimeZone(tz));
		return df.format(new Date());
	}

	/*
	 * 将日期转化成指定格式字符串
	 */
	public static String getDateStr(Date d, String sdf) {

		DateFormat df = new SimpleDateFormat(sdf);
		return df.format(d);
	}

	/*
	 * 获得输入日期的前后日期
	 */
	public static String addDateStr(Date d, int days, String sdf) {
		Calendar c = Calendar.getInstance();
		c.setTime(d);
		c.add(Calendar.DAY_OF_YEAR, days);
		DateFormat df = new SimpleDateFormat(sdf);
		return df.format(c.getTime());
	}

	public static String getDateEndTimeStr(Date d, int days) {
		Calendar c2 = Calendar.getInstance();
		c2.setTime(d);
		c2.set(Calendar.HOUR_OF_DAY, 23);
		c2.set(Calendar.MINUTE, 59);
		c2.set(Calendar.SECOND, 59);
		c2.add(Calendar.DAY_OF_YEAR, days);
		return DATETIME_FORMAT.format(c2.getTime());
	}

	public static String getDateStartTimeStr(Date d, int days) {
		Calendar c2 = Calendar.getInstance();
		c2.setTime(d);
		c2.set(Calendar.HOUR_OF_DAY, 0);
		c2.set(Calendar.MINUTE, 0);
		c2.set(Calendar.SECOND, 0);
		c2.add(Calendar.DAY_OF_YEAR, days);
		return DATETIME_FORMAT.format(c2.getTime());
	}

	/**
	 * 
	 * @author:caoshanshan(caoshsh@corp.2cn.com)) description:在原有时间上增加或减少n个小时
	 * @params: String
	 */
	public static String getDateByAddHour(Date d, int hour) {
		Calendar c2 = Calendar.getInstance();
		c2.setTime(d);
		c2.add(Calendar.HOUR, hour);
		return DATETIME_FORMAT.format(c2.getTime());
	}

	/**
	 * @param d
	 * @return 返回当前日期的开始时间
	 * @description
	 */
	public static Date getDateStartTime(Date d, int days) {
		Calendar c1 = Calendar.getInstance();
		c1.setTime(d);
		c1.set(Calendar.HOUR_OF_DAY, 0);
		c1.set(Calendar.MINUTE, 0);
		c1.set(Calendar.SECOND, 0);
		c1.add(Calendar.DAY_OF_YEAR, days);
		return c1.getTime();
	}

	/**
	 * @param d
	 * @return 返回当前日期的结束时间
	 * @description ...
	 */
	public static Date getDateEndTime(Date d, int days) {
		Calendar c2 = Calendar.getInstance();
		c2.setTime(d);
		c2.set(Calendar.HOUR_OF_DAY, 23);
		c2.set(Calendar.MINUTE, 59);
		c2.set(Calendar.SECOND, 59);
		c2.add(Calendar.DAY_OF_YEAR, days);
		return c2.getTime();
	}

	public static Date getFirstDayOfMonth(Date d) {
		Calendar c2 = Calendar.getInstance();
		c2.setTime(d);
		c2.set(Calendar.DAY_OF_MONTH, 1);
		c2.set(Calendar.HOUR_OF_DAY, 0);
		c2.set(Calendar.MINUTE, 0);
		c2.set(Calendar.SECOND, 0);
		return c2.getTime();
	}

	public static Date getLastDayOfMonth(Date d) {
		Calendar c2 = Calendar.getInstance();
		c2.setTime(d);
		c2.set(Calendar.DAY_OF_MONTH, c2
				.getActualMaximum(Calendar.DAY_OF_MONTH));
		c2.set(Calendar.HOUR_OF_DAY, 23);
		c2.set(Calendar.MINUTE, 59);
		c2.set(Calendar.SECOND, 59);
		return c2.getTime();
	}

	public static Date addDate(Date d, int days) {
		Calendar c = Calendar.getInstance();
		c.setTime(d);
		c.add(Calendar.DAY_OF_YEAR, days);
		return c.getTime();
	}

	public static int getDayOfDate(Date d) {
		Calendar c = Calendar.getInstance();
		c.setTime(d);
		return c.get(Calendar.DAY_OF_MONTH);
	}

	public static boolean isNumeric1(String str) {
		Pattern pattern = Pattern.compile("[0-9]*");
		return pattern.matcher(str).matches();
	}

	/**
	 * @author:caoshanshan(caoshsh@corp.2cn.com)) description:讲日期字符串转换为日期格式
	 * @throws ParseException
	 * @params: Date
	 */
	public static Date parseDateIgnoreCase(String dateStr)
			throws ParseException {
		if (dateStr == null || "".equalsIgnoreCase(dateStr)) {
			return null;
		} else {
			return DATE_FORMAT.parse(dateStr);
		}
	}

	public static Date parseDate(String dateStr, String type) throws Exception {
		if (dateStr == null || "".equalsIgnoreCase(dateStr)) {
			return null;
		} else {
			SimpleDateFormat dateFormat = new SimpleDateFormat(type);
			return dateFormat.parse(dateStr);
		}
	}

	public static String format(Date date, String fmt) {
		DateFormat formatter = new SimpleDateFormat(fmt);
		return formatter.format(date);
	}

	public static String format(Date date) {
		if(date == null){
			return "";
		}
		return format(date, "yyyy-MM-dd");
	}

	public static String format() {
		return format(new Date(System.currentTimeMillis()), "yyyy-MM-dd");
	}

	public static String formatDateTime(Date date) {
		return format(date, "yyyy-MM-dd HH:mm:ss");
	}

	public static String formatDateTime() {
		return format(new Date(System.currentTimeMillis()),
				"yyyy-MM-dd HH:mm:ss");
	}

	// 获取当前时间戳 从1970年到当前的毫秒数
	public static long getTimeInMillis() {
		Calendar calendar = Calendar.getInstance();
		TimeZone tz = TimeZone.getTimeZone("GMT");
		calendar.setTimeZone(tz);
		return calendar.getTimeInMillis();// 本次提交当前时间戳。长整型，是从1970年到当前的毫秒数。
	}

	public static Date getNow() {
		return new Date(System.currentTimeMillis());
	}

	// 获取某一天所在那一年的第一天
	public static Date getFirstDayOfYear(Date date) {
		Calendar cal = Calendar.getInstance();
		cal.setTime(date);
		cal.set(Calendar.DAY_OF_YEAR, cal
				.getActualMinimum(Calendar.DAY_OF_YEAR));
		return getToday(cal.getTime());
	}
	// 获取某一天所在那一年的最后一天
		public static Date getLastDayOfYear(Date date) {
			Calendar cal = Calendar.getInstance();
			cal.setTime(date);
			cal.set(Calendar.DAY_OF_YEAR, cal
					.getActualMaximum(Calendar.DAY_OF_YEAR));
			return getTodayLast(cal.getTime());
		}
	// 得到今天凌晨的时间.
	public static Date getToday() {
		Calendar cal = Calendar.getInstance();
		cal.set(Calendar.HOUR_OF_DAY, 0);
		cal.set(Calendar.MINUTE, 0);
		cal.set(Calendar.SECOND, 0);
		cal.set(Calendar.MILLISECOND, 0);
		return cal.getTime();
	}

	// 得到今日23：59 时间
	public static Date getTodayLast() {
		Calendar cal = Calendar.getInstance();
		cal.set(Calendar.HOUR_OF_DAY, 23);
		cal.set(Calendar.MINUTE, 59);
		cal.set(Calendar.SECOND, 59);
		cal.set(Calendar.MILLISECOND, 999);
		return cal.getTime();
	}

	// 得到某一天的凌晨时间
	public static Date getToday(Date date) {
		Calendar cal = Calendar.getInstance();
		cal.setTime(date);
		cal.set(Calendar.HOUR_OF_DAY, 0);
		cal.set(Calendar.MINUTE, 0);
		cal.set(Calendar.SECOND, 0);
		cal.set(Calendar.MILLISECOND, 0);
		return cal.getTime();
	}

	// 得到某一天的23：59 时间
	public static Date getTodayLast(Date date) {
		Calendar cal = Calendar.getInstance();
		cal.setTime(date);
		cal.set(Calendar.HOUR_OF_DAY, 23);
		cal.set(Calendar.MINUTE, 59);
		cal.set(Calendar.SECOND, 59);
		cal.set(Calendar.MILLISECOND, 999);
		return cal.getTime();
	}

	// 得到几天前当天时间===================================================================
	public static Date getSomeDate(Date date, int dayNum) {
		Calendar cal = Calendar.getInstance();
		long DAY = 1000 * 3600 * 24;
		cal.setTimeInMillis(date.getTime() + DAY * (long) dayNum);
		return cal.getTime();
	}

	// 得到几月前当天时间===================================================================
	public static Date getSomeMonthDate(Date date, int monthNum) {
		Calendar cal = Calendar.getInstance();
		cal.setTime(date);
		cal.set(Calendar.MONTH, cal.get(Calendar.MONTH) + monthNum);
		return cal.getTime();
	}

	// 得到24小时内某小时的开始时间
	public static Date getSubsectionHourBegin(Date date, int sub) {
		Calendar cal = Calendar.getInstance();
		cal.setTime(date);
		cal.set(Calendar.HOUR_OF_DAY, sub);
		cal.set(Calendar.MINUTE, 0);
		cal.set(Calendar.SECOND, 0);
		cal.set(Calendar.MILLISECOND, 0);
		return cal.getTime();
	}

	// 得到24小时内某小时的末尾时间
	public static Date getSubsectionHourEnd(Date date, int sub) {
		Calendar cal = Calendar.getInstance();
		cal.setTime(date);
		cal.set(Calendar.HOUR_OF_DAY, sub);
		cal.set(Calendar.MINUTE, 59);
		cal.set(Calendar.SECOND, 59);
		cal.set(Calendar.MILLISECOND, 999);
		return cal.getTime();
	}

	public static Date getYesterday() {
		Date today = DateUtil.getNow();
		long t = today.getTime();
		Date date = new Date(t - 24 * 60 * 60 * 1000l);
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
		try {
			date = sdf.parse(sdf.format(date));
		} catch (ParseException e) {

		}
		return date;
	}

	public static Date getTheDay(Date date) {
		Calendar cal = Calendar.getInstance();
		cal.setTime(date);
		cal.set(Calendar.HOUR_OF_DAY, 0);
		cal.set(Calendar.MINUTE, 0);
		cal.set(Calendar.SECOND, 0);
		cal.set(Calendar.MILLISECOND, 0);
		return cal.getTime();
	}

	public static int getYear(Date date) {
		Calendar cld = Calendar.getInstance();
		cld.setTime(date);
		return cld.get(Calendar.YEAR);
	}

	// 返回的月数是 自然月-1 也就是说返回的月是从 0--11
	public static int getMonth(Date date) {
		Calendar cld = Calendar.getInstance();
		cld.setTime(date);
		return cld.get(Calendar.MONTH);
	}

	public static int getDate(Date date) {
		Calendar cld = Calendar.getInstance();
		cld.setTime(date);
		return cld.get(Calendar.DAY_OF_MONTH);
	}

	public static int getHour(Date date) {
		Calendar cld = Calendar.getInstance();
		cld.setTime(date);
		return cld.get(Calendar.HOUR_OF_DAY);
	}

	public static int getMin(Date date) {
		Calendar cld = Calendar.getInstance();
		cld.setTime(date);
		return cld.get(Calendar.MINUTE);
	}

	// 得到这个星期开始的时间,星期的开始从getFirstDayOfWeek()得到
	public static Date getThisWeekStart() {
		Calendar cal = Calendar.getInstance();
		cal.add(Calendar.DATE, -(cal.get(Calendar.DAY_OF_WEEK) - 1));
		return getTheDay(cal.getTime());
	}

	// 本月的开始
	public static Date getThisMonthStart() {
		Calendar cal = Calendar.getInstance();
		cal.set(Calendar.DAY_OF_MONTH, 1);
		return getTheDay(cal.getTime());
	}

	// 本月的开始
	public static Date getMonthStart(Date date) {
		Calendar cal = Calendar.getInstance();
		cal.setTime(date);
		cal.set(Calendar.DAY_OF_MONTH, 1);
		return getTheDay(cal.getTime());
	}

	public static Date getTheMonthStart(int amount) {
		Calendar cal = Calendar.getInstance();
		cal.setTime(getThisMonthStart());
		cal.add(Calendar.MONTH, amount);
		return cal.getTime();
	}

	// 本月的结束
	public static Date getThisMonthEnd() {
		Calendar cal = Calendar.getInstance();
		cal.set(Calendar.DATE, cal.getActualMaximum(Calendar.DAY_OF_MONTH));
		return getTodayLast(cal.getTime());
	}
	// 本月的结束
	public static Date getMonthEnd(Date date) {
		Calendar cal = Calendar.getInstance();
		cal.setTime(date);
		cal.set(Calendar.DATE, cal.getActualMaximum(Calendar.DAY_OF_MONTH));
		return getTodayLast(cal.getTime());
	}
	
	//当月天数
	public static int getMonthDay(Date date){
		Calendar cal = Calendar.getInstance();
		cal.setTime(date);
		return cal.getActualMaximum(Calendar.DAY_OF_MONTH);
	}
	
	
	// n分钟前或后 + -
	public static Date addMinute(Date date, int minute) {
		Calendar cal = Calendar.getInstance();
		cal.setTime(date);
		cal.add(Calendar.MINUTE, minute);
		return new Date(cal.getTime().getTime());
	}

	// n小时前或后 + -
	public static Date addHour(Date date, int hour) {
		Calendar cal = Calendar.getInstance();
		cal.setTime(date);
		cal.add(Calendar.HOUR, hour);
		return new Date(cal.getTime().getTime());
	}

	// n天前或后 + -
	public static Date addDay(Date date, int day) {
		Calendar cal = Calendar.getInstance();
		cal.setTime(date);
		cal.add(Calendar.DATE, day);

		return new Date(cal.getTime().getTime());
	}

	// n月前或后 + -
	public static java.util.Date addMonth(java.util.Date date, int month) {
		Calendar cal = Calendar.getInstance();
		cal.setTime(date);
		cal.add(Calendar.MONTH, month);

		return new java.util.Date(cal.getTime().getTime());
	}

	// n年前或后 + -
	public static java.util.Date addYear(java.util.Date date, int year) {
		Calendar cal = Calendar.getInstance();
		cal.setTime(date);
		cal.add(Calendar.YEAR, year);

		return new java.util.Date(cal.getTime().getTime());
	}

	// 计算两个日期之间的天数
	public static int getDays(Date date1, Date date2) {
		int days = 0;
		days = (int) (Math.abs((date2.getTime() - date1.getTime())) / (24 * 60 * 60 * 1000));
		return days;
	}

	public static int getSecond(Date date1, Date date2) {
		int second = 0;
		second = (int) (Math.abs((date1.getTime() - date2.getTime()) / 1000));
		return second;
	}

	public static int getMinute(Date date1, Date date2) {
		int minute = 0;
		minute = (int) (Math.abs((date1.getTime() - date2.getTime())
				/ (60 * 1000)));
		return minute;
	}

	public static int getCompareMinute(Date date1, Date date2) {
		int minute = 0;
		minute = (int) ((date1.getTime() - date2.getTime()) / (60 * 1000));
		return minute;
	}

	public static int getCompareDate(Date date1, Date date2) {
		int date = 0;
		date = (int) ((date1.getTime() - date2.getTime()) / (24 * 3600 * 1000));
		return date;
	}

	// 计算两个日期之间的时间差 详细到秒 返回类型为String
	public static String getDayDif(Date date1, Date date2) {
		long DAY = 24 * 60 * 60 * 1000;
		long between = Math.abs((date2.getTime() - date1.getTime()));
		long day = between / DAY;
		long hour = (between / (60 * 60 * 1000) - day * 24);
		long min = ((between / (60 * 1000)) - day * 24 * 60 - hour * 60);
		long s = (between / 1000 - day * 24 * 60 * 60 - hour * 60 * 60 - min * 60);
		return "" + day + "天" + hour + "小时" + min + "分" + s + "秒";
	}
	
	public static Date[] getMonthStartAndEnd(String dateStr) throws Exception{
		Date[] date = new Date[2];
		if(!StockUtil.isEmpty(dateStr)){
			Date datePar = parseDate(dateStr, "yyyy-MM-dd");
			date [0]=getFirstDayOfMonth(datePar);
			date [1]=getLastDayOfMonth(datePar);
		}
		return date;
	}

	//根据月份判断是第几季度
	public static int getSeason(Date date){
		int season = 0;
		int month = 0;
		month = getMonth(date);
		switch(month){
		case Calendar.JANUARY:
		case Calendar.FEBRUARY:
		case Calendar.MARCH:
			season = 1;
			break;
		case Calendar.APRIL:
		case Calendar.MAY:
		case Calendar.JUNE:
			season = 2;
			break;
		case Calendar.JULY:	
		case Calendar.AUGUST:	
		case Calendar.SEPTEMBER:
			season = 3;
			break;
		case Calendar.OCTOBER:	
		case Calendar.NOVEMBER:	
		case Calendar.DECEMBER:
			season = 4;
			break;
		default:
			break;
		}
		return season;
	}
	
	
	public static void main(String[] args) throws Exception{
		System.out.println(new Date());
		System.out.println(getDateStartTime(new Date(), -10));
		String myString = "2014-04-09";
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
		try {
			Date d = sdf.parse(myString);
			System.out.println(getCompareDate(d, new Date()));
		} catch (ParseException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		System.out.println(DateUtil.parse("2014-04-12 12:15:33", DateUtil.DATETIME));
		System.out.println(DateUtil.parse("2014-04-12 12:15:33", DateUtil.DATE));
		System.out.println(DateUtil.parse("2014-04-12 12:15:33", DateUtil.MONTH));

		Thread t1 = new Thread() {
			@Override
			public void run() {
				System.out.println(DateUtil.formatNew(new Date(), DateUtil.DATETIME));
			}
		};

		Thread t2 = new Thread() {
			@Override
			public void run() {
				System.out.println(DateUtil.formatNew(new Date(), DateUtil.DATE));
			}
		};

		Thread t3 = new Thread() {
			@Override
			public void run() {
				System.out.println(DateUtil.formatNew(new Date(), DateUtil.MONTH));
			}
		};

		Thread t4 = new Thread() {
			@Override
			public void run() {
				System.out.println(DateUtil.formatNew(new Date(), DateUtil.MSEC));
			}
		};

		Thread t5 = new Thread() {
			@Override
			public void run() {
				System.out.println(DateUtil.formatNew(new Date(), DateUtil.FULL_DATETIME));
			}
		};

		Thread t6 = new Thread() {
			@Override
			public void run() {
				System.out.println(DateUtil.formatNew(new Date(), DateUtil.DATETIME));
			}
		};
		
		Thread t7 = new Thread() {
			@Override
			public void run() {
				Date date = null;
				try {
					date = DateUtil.parse("2015-12-05 12:15:33", DateUtil.DATE);
				} catch (ParseException e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				}
				System.out.println(DateUtil.formatNew(new Date(), DateUtil.DATETIME));
				System.out.println(DateUtil.getSeason(date));
			}
		};
		System.out.println("单线程执行: ");
        ExecutorService exec = Executors.newFixedThreadPool(10);
        exec.execute(t1);
        exec.execute(t2);
        exec.execute(t3);
        exec.execute(t4);
        exec.execute(t5);
        exec.execute(t6);
        exec.execute(t7);
        exec.shutdown();

       

//        System.out.println("双线程执行: ");
//        ExecutorService exec2 = Executors.newFixedThreadPool(2);
//        exec2.execute(t1);
//        exec2.execute(t2);
//        exec2.execute(t3);
//        exec2.execute(t4);
//        exec2.execute(t5);
//        exec2.execute(t6);
//        exec2.shutdown();

	}


}
