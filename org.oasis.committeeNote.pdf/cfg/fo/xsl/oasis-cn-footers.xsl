<?xml version='1.0'?>

<!-- ===================== CHANGE LOG ================================ -->
<!--                                                                   -->
<!-- 05 Sep 2015 KJE: Added change log. Moved text to en.xml.          -->
<!-- o5 Jan 2016 BT: Added cnVersion variable. Modified footers.       -->
<!-- 31 Jan 2016 KJE: Replaced call to deprecated template             -->
<!--                                                                   -->
<!-- ================================================================= --> 

<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                xmlns:xs="http://www.w3.org/2001/XMLSchema" 
                xmlns:fo="http://www.w3.org/1999/XSL/Format" 
                xmlns:opentopic-func="http://www.idiominc.com/opentopic/exsl/function" 
                version="2.0">
 
 <!-- VARIABLES: METADATA --> 
 <!-- Based on metadata from root DITA map -->
 <!-- Used in file names and variables called in footers -->
 
 <xsl:variable name="hwDocumentTitle">
  <xsl:value-of
   select="
   /*[contains(@class, ' bookmap/bookmap ')]/*
   /*[contains(@class, ' bookmap/booktitle ')]
   /*[contains(@class, ' bookmap/mainbooktitle ')]"
  />
 </xsl:variable>
 
 <xsl:variable name="specSubtitle1"
  select="
  /*[contains(@class, ' bookmap/bookmap ')]/*
  /*[contains(@class, ' bookmap/booktitle ')]
  /*[contains(@class, ' bookmap/booktitlealt ')][@outputclass = 'specificationSubtitle1']"/>
 
 <xsl:variable name="specSubtitle2"
  select="
  /*[contains(@class, ' bookmap/bookmap ')]/*
  /*[contains(@class, ' bookmap/booktitle ')]
  /*[contains(@class, ' bookmap/booktitlealt ')][@outputclass = 'specificationSubtitle2']"/>
 
 <!-- VARIABLES: FOOTERS -->
 
 <!-- Variable: Approval date --> 
 <xsl:variable name="oasis-date">
  <xsl:value-of
   select="
   /*[contains(@class, ' bookmap/bookmap ')]/*
   /*[contains(@class, ' bookmap/booktitle ')]
   /*[contains(@class, ' bookmap/booktitlealt ')][@outputclass = 'specificationApproved']"
  />
 </xsl:variable>
 
 <!-- Variable: Copyright year -->
 <xsl:variable name="copyright-year">
  <xsl:choose>
   <xsl:when
    test="
    normalize-space((
    /*[contains(@class, ' bookmap/bookmap ')]/*
    /*[contains(@class, ' bookmap/bookmeta ')]
    /*[contains(@class, ' bookmap/bookrights ')]
    /*[contains(@class, ' bookmap/copyrlast ')]
    /*[contains(@class, ' bookmap/year ')])) = ''">
    <xsl:value-of
     select="
     /*[contains(@class, ' bookmap/bookmap ')]/*
     /*[contains(@class, ' bookmap/bookmeta ')]
     /*[contains(@class, ' bookmap/bookrights ')]
     /*[contains(@class, ' bookmap/copyrfirst ')]
     /*[contains(@class, ' bookmap/year ')]"
    />
   </xsl:when>
   <xsl:otherwise>
    <xsl:value-of
     select="
     /*[contains(@class, ' bookmap/bookmap ')]/*
     /*[contains(@class, ' bookmap/bookmeta ')]
     /*[contains(@class, ' bookmap/bookrights ')]
     /*[contains(@class, ' bookmap/copyrlast ')]
     /*[contains(@class, ' bookmap/year ')]"
    />
   </xsl:otherwise>
  </xsl:choose>
 </xsl:variable>
 
 <!-- Variable: Work product level -->  
 <xsl:variable name="ditaproduct">
  <!--<xsl:text>Non-Standards Track</xsl:text>-->
  <xsl:call-template name="getVariable">
   <xsl:with-param name="id" select="'Work product track'" />
  </xsl:call-template>
 </xsl:variable>
 
 <!-- Variable: Work product status --> 
 <xsl:variable name="cnLevel">
  <xsl:value-of
   select="
   /*[contains(@class, ' bookmap/bookmap ')]/*
   /*[contains(@class, ' bookmap/booktitle ')]
   /*[contains(@class, ' bookmap/booktitlealt ')][@outputclass = 'specificationSubtitle1']"
  />
 </xsl:variable>

</xsl:stylesheet>

