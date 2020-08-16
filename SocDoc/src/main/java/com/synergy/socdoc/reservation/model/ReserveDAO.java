package com.synergy.socdoc.reservation.model;

import java.util.HashMap;
import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.synergy.socdoc.member.HpInfoVO;
import com.synergy.socdoc.member.MemberVO;

@Repository
public class ReserveDAO implements InterReserveDAO {

	@Autowired
	private SqlSessionTemplate sqlsession;
	
	@Override
	public String getContent() {
		String content = sqlsession.selectOne("test.getContent");
		return content;
	}

	// 병원 정렬하기 (전체)
	/*@Override
	public List<HpInfoVO> hospital_select() {
		List<HpInfoVO> hpinfovoList = sqlsession.selectList("test.hospital_select");
		return hpinfovoList;
	}*/
	
	
	// 환자정보 가져오기(내자신)
	@Override
	public MemberVO viewMyinfo(String userid) {
		MemberVO membervo = sqlsession.selectOne("test.viewMyinfo", userid);
	      return membervo;
	}

	/*@Override
	public List<HpInfoVO> hpinfovoList() {
		List<HpInfoVO> hpinfovoList = sqlsession.selectList("test.hpinfovoList");
		return hpinfovoList;
	}*/

	@Override
	public List<String> deptIdList() {
		List<String> deptIdList = sqlsession.selectList("test.deptIdList");
		return deptIdList;
	}


	@Override
	public List<HashMap<String, String>> hpinfovoList(HashMap<String, Object> paraMap) {
		List<HashMap<String, String>> hpinfovoList = sqlsession.selectList("test.hpinfovoList",paraMap);
		return hpinfovoList;
	}

	@Override
	public int getTotalCount(HashMap<String, String> paraMap) {
		// TODO Auto-generated method stub
		return 0;
	}
	/*@Override
	public int getTotalCount(HashMap<String, String> paraMap) {
		// TODO Auto-generated method stub
		return 0;
	}
*/

	
	

}
