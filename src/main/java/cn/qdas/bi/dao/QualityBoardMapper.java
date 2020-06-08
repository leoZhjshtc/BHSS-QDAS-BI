package cn.qdas.bi.dao;


import cn.qdas.bi.bean.QualityBoard;

import org.apache.ibatis.annotations.Param;

import java.util.List;
import java.util.Map;

public interface QualityBoardMapper {
	List getAllProductLine();
	//List getAlarmCountByProductLine(@Param("productLineNames")String[] productLineNames, @Param("startTime")String startTime, @Param("endTime")String endTime);
	List getAlarmCountByProductLine(@Param("startTime")String startTime, @Param("endTime")String endTime,@Param("productLineNames")String[] productLineNames);
	List getAlarmCountByProductLineByCount(@Param("productLineNames")String[] productLineNames);
	List getTeilAlarmCountData(QualityBoard qb);
	List getTeilAlarmCountDataByCount(QualityBoard qb);
	List getMerkmalAlarmCountData(QualityBoard qb);
	List getMerkmalAlarmCountDataByCount(QualityBoard qb);
	List getWertevarChartData(QualityBoard qb);
	List getWertevarChartDataByCount(QualityBoard qb);
	List getWertevarDate(QualityBoard qb);
	List<Map> getQbFormData(@Param("productLineNames")String[] productLineNames, @Param("startTime")String startTime, @Param("endTime")String endTime);
	List<Map> getQbTableData(@Param("teilId")String teilId,@Param("merkmalId")String merkmalId, @Param("startTime")String startTime, @Param("endTime")String endTime);
	List<Map> getQbTableDataByCount(@Param("teilId")String teilId,@Param("merkmalId")String merkmalId);
	List<Map> getQbTeilFormData(@Param("teilId")String teilId,@Param("startTime")String startTime,@Param("endTime")String endTime);
	
}
