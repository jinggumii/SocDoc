package com.synergy.socdoc.reservation.service;

import java.util.HashMap;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.synergy.socdoc.member.HpInfoVO;
import com.synergy.socdoc.member.MemberVO;
import com.synergy.socdoc.reservation.model.InterReserveDAO;

@Service
public class ReserveService implements InterReserveService {
	
	@Autowired
	private InterReserveDAO dao;

	@Override
	public String getContent() {
		String content = dao.getContent();
		return content;
	}

	// 병원정보가져오기
	@Override
	public List<HpInfoVO> hospital_select() {
		List<HpInfoVO> hpinfovoList = dao.hospital_select();
		return hpinfovoList;
	}

	@Override
	public MemberVO viewMyinfo(String userid) {
		MemberVO membervo = dao.viewMyinfo(userid);
	      return membervo;
	}



}
