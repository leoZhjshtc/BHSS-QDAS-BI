package cn.qdas.bi.service.impl;


import javax.annotation.Resource;

import cn.qdas.bi.bean.QualityBoard;

import org.springframework.stereotype.Service;

import com.github.pagehelper.Page;
import com.github.pagehelper.PageHelper;

import cn.qdas.bi.dao.QualityBoardMapper;
import cn.qdas.bi.service.IQualityBoardService;
import cn.qdas.core.V11Webservice.V11WebServiceClient;

import java.text.SimpleDateFormat;
import java.util.*;

@Service
@SuppressWarnings(value = { "all" })
public class QualityBoardServiceImpl implements IQualityBoardService{
	@Resource
	QualityBoardMapper qbm;

	@Override
	public List getAllProductLine(QualityBoard qb,List<Map> plList) {
		String [] plArr=new String[plList.size()];
		for(int i=0;i<plList.size();i++) {
			plArr[i]=(String) plList.get(i).get("productLine_name");
		}
		List<Map> list=new ArrayList<Map>();
		if(qb.getShowDataCount()!=null) {
			list=qbm.getAlarmCountByProductLineByCount(plArr);
			
		}else {
			list=qbm.getAlarmCountByProductLine(qb.getStartTime(),qb.getEndTime(),plArr);
		}
		for(int i=0;i<list.size();i++){
			Map map=list.get(i);
			if(null==map.get("TEKOSTST")||"".equals(map.get("TEKOSTST"))){
				list.remove(i);
				i--;
			}else{
				if(Integer.parseInt(String.valueOf(map.get("wvCount")))==0){
					map.put("qualityLevel","3");
				}else if(Integer.parseInt(String.valueOf(map.get("alarmCount1")))>0||Integer.parseInt(String.valueOf(map.get("alarmCount2")))>0||Integer.parseInt(String.valueOf(map.get("alarmCount65536")))>0){
					map.put("qualityLevel","2");
				}else if(Integer.parseInt(String.valueOf(map.get("alarmCount16")))>0||Integer.parseInt(String.valueOf(map.get("alarmCount32")))>0){
					map.put("qualityLevel","1");
				}else{
					map.put("qualityLevel","0");
				}
				map.put("buttonId",String.valueOf(map.get("TEKOSTST")).replaceAll(" ", "-"));
			}
		}
		return list;
	}
	public List getTeilData(QualityBoard qb) {
		List<Map> list=new ArrayList<Map>();
		if(qb.getShowDataCount()!=null) {
			list=qbm.getTeilAlarmCountDataByCount(qb);
		}else {
			list=qbm.getTeilAlarmCountData(qb);
		}
		for(int i=0;i<list.size();i++){
			Map map=list.get(i);
			if(Integer.parseInt(String.valueOf(map.get("wvCount")))==0) {
				map.put("qualityLevel","3");
			}else if(Integer.parseInt(String.valueOf(map.get("alarmCount1")))>0||Integer.parseInt(String.valueOf(map.get("alarmCount2")))>0||Integer.parseInt(String.valueOf(map.get("alarmCount65536")))>0){
				map.put("qualityLevel","2");
			}else if(Integer.parseInt(String.valueOf(map.get("alarmCount16")))>0||Integer.parseInt(String.valueOf(map.get("alarmCount32")))>0){
				map.put("qualityLevel","1");
			}else{
				map.put("qualityLevel","0");
			}
		}
		return list;
	}
	public List getMerkmalData(QualityBoard qb) {
		List<Map> list=new ArrayList<Map>();
		if(qb.getShowDataCount()!=null) {
			list=qbm.getMerkmalAlarmCountDataByCount(qb);
			
		}else {
			list=qbm.getMerkmalAlarmCountData(qb);
		}
		for(int i=0;i<list.size();i++){
			Map map=list.get(i);
			if(Integer.parseInt(String.valueOf(map.get("wvCount")))==0) {
				map.put("qualityLevel","3");
			}else if(Integer.parseInt(String.valueOf(map.get("alarmCount1")))>0||Integer.parseInt(String.valueOf(map.get("alarmCount2")))>0||Integer.parseInt(String.valueOf(map.get("alarmCount65536")))>0){
				map.put("qualityLevel","2");
			}else if(Integer.parseInt(String.valueOf(map.get("alarmCount16")))>0||Integer.parseInt(String.valueOf(map.get("alarmCount32")))>0){
				map.put("qualityLevel","1");
			}else{
				map.put("qualityLevel","0");
			}
		}
		return list;
	}
	public List getWertevarChartData(QualityBoard qb) {
		List<Map> list=new ArrayList<Map>();
		
		if(qb.getShowDataCount()!=null) {
			list=qbm.getWertevarChartDataByCount(qb);
		}else {
			list=qbm.getWertevarChartData(qb);
		}
		for(int i=0;i<list.size();i++) {
			list.get(i).put("WVDATZEIT", String.valueOf(list.get(i).get("WVDATZEIT")).substring(0, 19));
		}
		return list;
	}
	public List getWertevarDate(QualityBoard qb) {
		List<Map> list=qbm.getWertevarDate(qb);
		for(int i=0;i<list.size();i++) {
			list.get(i).put("WVDATZEIT", String.valueOf(list.get(i).get("WVDATZEIT")).substring(0, 19));
		}
		return list;
	}
	public Map getQbFormData(Integer arrIndex,QualityBoard qb,List<Map> plList) {
		String[] plArr=new String[plList.size()];
		for(int i=0;i<plList.size();i++) {
			plArr[i]=(String) plList.get(i).get("productLine_name");
		}
		Map formMap=getQbFormDataByPage(plArr,arrIndex,qb.getStartTime(),qb.getEndTime());
		List<Map> formlist=(List<Map>) formMap.get("rows");
		Map reMap=new HashMap<String, Object>();
		if(formlist.size()==0) {
			return reMap;
		}
		List<Map> tableList=new ArrayList<Map>();
		if(qb.getShowDataCount()!=null) {
			tableList=qbm.getQbTableDataByCount(formlist.get(0).get("TETEIL").toString(), formlist.get(0).get("MEMERKMAL").toString());
		}else {
			tableList=qbm.getQbTableData(formlist.get(0).get("TETEIL").toString(), formlist.get(0).get("MEMERKMAL").toString(),qb.getStartTime(),qb.getEndTime());
		}
		for(int i=0;i<tableList.size();i++) {
			if(!"".equals(String.valueOf(tableList.get(i).get("WVDATZEIT")))&&null!=String.valueOf(tableList.get(i).get("WVDATZEIT"))){
				tableList.get(i).put("WVDATZEIT", String.valueOf(tableList.get(i).get("WVDATZEIT")).substring(0,19));
			}
		}
		reMap.put("formList", formlist.get(0));
		reMap.put("tableList", tableList);
		reMap.put("total", formMap.get("total"));
		return reMap;
	}
	public Map getQbFormDataByPage(String[] plArr,int arrIndex,String startTime,String endTime) {
		Page page = PageHelper.startPage(arrIndex, 1, true);
		List<Map> formlist=qbm.getQbFormData(plArr,startTime,endTime);
		Map map=new HashMap<String,Object>();
		map.put("rows", formlist);
		map.put("total", page.getTotal());
		return map;
	}
	/**
	 * 单个产线的轮播
	 */
	public Map getQbTeilsFormData(String [] plArr,Integer arrIndex,QualityBoard qb) {
		Map formMap=getQbFormDataByPage(plArr,arrIndex,qb.getStartTime(),qb.getEndTime());
		List<Map> formlist=(List<Map>) formMap.get("rows");
		List<Map> tableList=new ArrayList<Map>();
		if(qb.getShowDataCount()!=null) {
			tableList=qbm.getQbTableDataByCount(formlist.get(0).get("TETEIL").toString(), formlist.get(0).get("MEMERKMAL").toString());
		}else {
			tableList=qbm.getQbTableData(formlist.get(0).get("TETEIL").toString(), formlist.get(0).get("MEMERKMAL").toString(),qb.getStartTime(),qb.getEndTime());
		}
		for(int i=0;i<tableList.size();i++) {
			if(!"".equals(String.valueOf(tableList.get(i).get("WVDATZEIT")))&&null!=String.valueOf(tableList.get(i).get("WVDATZEIT"))){
				tableList.get(i).put("WVDATZEIT", String.valueOf(tableList.get(i).get("WVDATZEIT")).substring(0,19));
			}
		}
		Map reMap=new HashMap<String, Object>();
		reMap.put("formList", formlist.get(0));
		reMap.put("tableList", tableList);
		reMap.put("total", formMap.get("total"));
		return reMap;
	}
	/**
	 * 获取单个零件轮播的所有数据
	 * @return
	 */
	public Map getQbTeilFormData(String teilId,Integer arrIndex,QualityBoard qb) {
		Map formMap=getQbTeilFormDataByPage(teilId,arrIndex,qb.getStartTime(),qb.getEndTime());
		List<Map> formlist=(List<Map>) formMap.get("rows");
		List<Map> tableList=new ArrayList<Map>();
		if(qb.getShowDataCount()!=null) {
			tableList=qbm.getQbTableDataByCount(formlist.get(0).get("TETEIL").toString(), formlist.get(0).get("MEMERKMAL").toString());
		}else {
			tableList=qbm.getQbTableData(formlist.get(0).get("TETEIL").toString(), formlist.get(0).get("MEMERKMAL").toString(),qb.getStartTime(),qb.getEndTime());
		}
		for(int i=0;i<tableList.size();i++) {
			if(!"".equals(String.valueOf(tableList.get(i).get("WVDATZEIT")))&&null!=String.valueOf(tableList.get(i).get("WVDATZEIT"))){
				tableList.get(i).put("WVDATZEIT", String.valueOf(tableList.get(i).get("WVDATZEIT")).substring(0,19));
			}
		}
		Map reMap=new HashMap<String, Object>();
		reMap.put("formList", formlist.get(0));
		reMap.put("tableList", tableList);
		reMap.put("total", formMap.get("total"));
		return reMap;
	}
	public Map getQbTeilFormDataByPage(String teilId,int arrIndex,String startTime,String endTime) {
		Page page = PageHelper.startPage(arrIndex, 1, true);
		List<Map> formlist=qbm.getQbTeilFormData(teilId,startTime,endTime);
		Map map=new HashMap<String,Object>();
		map.put("rows", formlist);
		map.put("total", page.getTotal());
		return map;
	}
	public Map getQdasGraphic(QualityBoard qb) throws Exception{
		String endTime=qb.getEndTime();
		if(endTime==null||"".equals(endTime)) {
			SimpleDateFormat sdf=new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
			endTime=sdf.format(new Date());
		}
		return V11WebServiceClient.getGraphic(qb.getTeilId(), qb.getMerkmalId(), qb.getStartTime(),endTime);
	}
	
	public Map getQdasGraphicAndCpk(QualityBoard qb) throws Exception {
		String endTime=qb.getEndTime();
		if(endTime==null||"".equals(endTime)) {
			SimpleDateFormat sdf=new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
			endTime=sdf.format(new Date());
		}
		return V11WebServiceClient.getGraphicAndCpk(qb.getTeilId(), qb.getMerkmalId(), qb.getStartTime(),endTime);
	}
}
