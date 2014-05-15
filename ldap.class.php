<?php
# Taha Al-jumaily
class ldap_auth{
   
   private $msg='';
   
   function __construct(){
      if((isset($_POST['password']) && isset($_POST['password']))&&
	     ($_POST['password']!='' && $_POST['password']!='')){
	    $u = "{$_POST['domain']}\\".(mysql_real_escape_string($_POST['username']));
		 $p = ($_POST['password']);
		 $this->msg = $this->ldap_valiate($u,$p);
		 }
      else{ $this->msg = "Note: Please choose your domain (AD or MC)"; }
      }


   function ldap_status(){ return $this->msg; }

   #mc22h1.mc.uky.edu
   #hospad05.mc.uky.edu
   function ldap_valiate($u,$p,$server="mc22h1.mc.uky.edu",$v=''){
      global $SESSION;
    
      // connect to ldap server
      $ldapconn = ldap_connect($server) or die("Could not connect to LDAP server.");
      
      if($ldapconn){
         // binding to ldap server
         $ldapbind = ldap_bind($ldapconn,$u,$p);
         
         // verify binding
         if($ldapbind){
            $SESSION->set_var('username',$_POST['username']);
		      header("location: main.php");
		      exit;
			   }
         else{ $v = '<font color="red">Login Failed</font>'; }
         }
      
      ldap_close($ldapconn);
      return $v;
      }



   }

?>
