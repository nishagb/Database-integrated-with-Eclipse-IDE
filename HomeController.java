package net.codejava.spring.controller;

import java.io.IOException;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import net.codejava.spring.dao.copy.ContactDAO;
import net.codejava.spring.model.Contact;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.ModelAndView;

@Controller
public class HomeController {

	/*
	@RequestMapping(value="/")
	public ModelAndView test(HttpServletResponse response) throws IOException{
		return new ModelAndView("home");
	}*/
	
	

	@Autowired
    private ContactDAO contactDAO;
	@RequestMapping(value="/")
	public ModelAndView listContact(ModelAndView model) throws IOException{
		
		System.out.println("inside / controller");
	    List<Contact> listContact = contactDAO.list();
	    model.addObject("listContact", listContact);
	    model.setViewName("home");
	 
	    return model;
	}
	
	@RequestMapping(value = "/newContact", method = RequestMethod.GET)
	public ModelAndView newContact(ModelAndView model) {
		System.out.println("inside /newcontact controller");
	    Contact newContact = new Contact();
	    model.addObject("contact", newContact);
	    model.setViewName("ContactForm");
	    return model;
	}
	
	@RequestMapping(value = "/saveContact", method = RequestMethod.POST)
	public ModelAndView saveContact(@ModelAttribute Contact contact) {
		System.out.println("inside /savecontact controller");
	    contactDAO.saveOrUpdate(contact);
	    return new ModelAndView("redirect:/");
	}
	
	@RequestMapping(value = "/deleteContact", method = RequestMethod.GET)
	public ModelAndView deleteContact(HttpServletRequest request) {
		System.out.println("inside /deletecontact controller");
	    int contactId = Integer.parseInt(request.getParameter("id"));
	    contactDAO.delete(contactId);
	    return new ModelAndView("redirect:/");
	}
	
	@RequestMapping(value = "/editContact", method = RequestMethod.GET)
	public ModelAndView editContact(HttpServletRequest request) {
		System.out.println("inside /editcontact controller");
	    int contactId = Integer.parseInt(request.getParameter("id"));
	    Contact contact = contactDAO.get(contactId);
	    ModelAndView model = new ModelAndView("ContactForm");
	    model.addObject("contact", contact);
	 
	    return model;
	}
	
	
	
}
