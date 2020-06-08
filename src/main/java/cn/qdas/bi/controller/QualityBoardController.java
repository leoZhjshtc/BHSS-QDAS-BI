package cn.qdas.bi.controller;

import cn.qdas.bi.bean.QualityBoard;
import cn.qdas.bi.service.IQualityBoardService;
import cn.qdas.core.bean.SystemSetupBean;
import cn.qdas.core.service.ISystemSetupService;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * @Auther: Leo-Zhou 周钧
 * @Date: 2019/6/28
 * @Description: cn.qdas.bi.controller
 */
@Controller
@RequestMapping("/qb")
public class QualityBoardController {
    @Resource
    IQualityBoardService iqbs;
    @Resource
    ISystemSetupService isss;
    @RequestMapping("initQb")
    public String initQbPage(SystemSetupBean ssb,Model model) {
//    	model.addAttribute("qbFactoryName", ssb.getFactoryName());
//    	model.addAttribute("qbWorkShopName", ssb.getWorkShopName());
//    	model.addAttribute("qbWorkShopDrawing", ssb.getWorkShopDrawingStr());
    	model.addAttribute("qbFactoryName", "烟台");
    	model.addAttribute("qbWorkShopName", "车间1");
    	model.addAttribute("qbWorkShopDrawing","YtP-Shopfloor1.png");
        return "bi/qb/qualityBoard";
    }
    @RequestMapping("getProductLineData")
    public String getProductLineData(Model model, QualityBoard qb,SystemSetupBean ssb,HttpServletRequest request) {
    	HttpSession session = request.getSession();
    	List<Map> pllist=isss.getProdectLineByFactory(ssb);
    	session.setAttribute("productLines", pllist);
        List<Map> list =new ArrayList<Map>();
        if(pllist.size()!=0) {
        	list=iqbs.getAllProductLine(qb,pllist);
            for(int i=0;i<list.size();i++){
    			Map map=list.get(i);
    			for(int j=0;j<pllist.size();j++) {
    				if(map.get("TEKOSTST").equals(pllist.get(j).get("productLine_name"))) {
    					map.put("productLine_topPosition", pllist.get(j).get("productLine_topPosition"));
    					map.put("productLine_leftPosition", pllist.get(j).get("productLine_leftPosition"));
    					map.put("point_topPosition", pllist.get(j).get("point_topPosition"));
    					map.put("point_leftPosition", pllist.get(j).get("point_leftPosition"));
    					break;
    				}
    			}
    		}
        }
        Map remap=new HashMap<String, String>();
        remap.put("plList", list);
        model.addAttribute("paramMap", remap);
        model.addAttribute("workShopDrawing", ssb.getWorkShopDrawingStr());
        model.addAttribute("factoryName", ssb.getFactoryName());
        model.addAttribute("workShopName", ssb.getWorkShopName());
        return "bi/qb/qbProductLineData";
    }
    @RequestMapping("getProductLineRealTime")
    @ResponseBody
    public List getProductLineRealTime(QualityBoard qb,SystemSetupBean ssb,HttpServletRequest request) {
    	HttpSession session = request.getSession();
    	List<Map> pllist=(List<Map>) session.getAttribute("productLines");
    	List<Map> list =new ArrayList<Map>();
    	if(pllist.size()!=0) {
    		list =iqbs.getAllProductLine(qb,pllist);
    		
    	}
    	 return list;
    }
    @RequestMapping("initTeilData")
    public String initTeilData(Model model, QualityBoard qb) {
        List <Map> teilList=iqbs.getTeilData(qb);
        Map map=new HashMap<String, String>();
        map.put("plId", qb.getProductLineName());
        map.put("teilList",teilList);
        model.addAttribute("paramMap", map);
        return "bi/qb/qbTeilData";
    }
    @RequestMapping("getTeilRealTime")
    @ResponseBody
    public List getTeilRealTime(QualityBoard qb) {
    	List list = iqbs.getTeilData(qb);
    	return list;
    }
    @RequestMapping("initMerkmalData")
    public String initMerkmalData(Model model,QualityBoard qb) {
        List list=iqbs.getMerkmalData(qb);
        Map map=new HashMap<String, String>();
        map.put("teilId", qb.getTeilId());
        map.put("merkmalList", list);
        model.addAttribute("paramMap", map);
        return "bi/qb/qbMerkmalData";
    }
    @RequestMapping("getMerkmalRealTime")
    @ResponseBody
    public List getMerkmalRealTime(QualityBoard qb) {
    	 List list=iqbs.getMerkmalData(qb);
    	 return list;
    }
    @RequestMapping("initWertevarChart")
    @ResponseBody
    public List getWertevarChartData(QualityBoard qb) {
        List list=iqbs.getWertevarChartData(qb);
        return list;
    }
    @RequestMapping("initDetailsDataPage")
    public String initDetailsDataPage(QualityBoard qb,Model model) {
    	model.addAttribute("teilId", qb.getTeilId());
    	model.addAttribute("merkmalId", qb.getMerkmalId());
    	return "bi/qb/detailsDataPage";
    }
    @RequestMapping("getWertevarData")
    @ResponseBody
    public List getWertevarData(QualityBoard qb) {
        List list = iqbs.getWertevarDate(qb);
        return list;
    }
    /**
     *
     * @param index 1:所有产线的数据  2：单个产线的数据 3：单个零件的数据
     * @param productLineName
     * @return
     */
    @RequestMapping("initQbShow")
    public String initQbShowPage(Model model,String index,String productLineName,String teilId) {
        model.addAttribute("index", index);
        model.addAttribute("productLineName", productLineName);
        model.addAttribute("teilId", teilId);
        return "bi/qb/qbShow";
    }
    @RequestMapping("getQbForm")
    @ResponseBody
    public Map getQbFormData(Integer arrIndex,QualityBoard qb,String teilId,String productLineName,String index,HttpServletRequest request) {
        Map map=new HashMap<String,Object>();
        switch (index) {
            case "1":
            	HttpSession session= request.getSession();
            	List list=(List) session.getAttribute("productLines");
            	if(list.size()!=0) {
            		 map=iqbs.getQbFormData(arrIndex,qb,list);
            	}
                break;
            case "2":
                String [] plArr= {productLineName};
                map=iqbs.getQbTeilsFormData(plArr,arrIndex,qb);
                break;
            case "3":
                map=iqbs.getQbTeilFormData(teilId,arrIndex,qb);
                break;
        }
        return map;
    }
    @RequestMapping("getQdasGraphicAndCpk")
    @ResponseBody
    public Map getQdasGraphicAndCpk(QualityBoard qb) {
    	Map imgMap=null;
		try {
			imgMap = iqbs.getQdasGraphicAndCpk(qb);
		} catch (Exception e) {
			imgMap.put("error", 1);
			e.printStackTrace();
		}
    	return imgMap;
    }
    @RequestMapping("initQdasCharts")
    public String initQdasCharts(QualityBoard qb,Model model) {
    	model.addAttribute("teilIdqc", qb.getTeilId());
    	model.addAttribute("merkmalqc", qb.getMerkmalId());
    	return "bi/qb/qdasCharts"; 
    }
    @RequestMapping("getQdasChartsData")
    @ResponseBody
    public Map getQdasChartsData(QualityBoard qb) {
    	Map imgMap=null;
		try {
			imgMap = iqbs.getQdasGraphic(qb);
		} catch (Exception e) {
			imgMap.put("error", 1);
			e.printStackTrace();
		}
    	return imgMap;
    }
    @RequestMapping("initQdasGraphic")
    public String initQdasGraphic() {
    	
    	return "bi/qb/qdasGraphic";
    }
}
