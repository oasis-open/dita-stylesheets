<?xml version='1.0'?>

<!-- ===================== CHANGE LOG ================================ -->
<!--                                                                   -->
<!-- 05 Sep 2015 KJE: Added change log. Moved text to en.xml.          -->
<!-- 05 Jan 2016  BT: Added cnVersion variable. Modified footers.      -->
<!-- 31 Jan 2016 KJE: Replaced call to deprecated template             -->
<!-- 06 May 2019 KJE: Renamed variables, removed obsolete variables,   -->
<!--                  changed outputclass values, added comments       -->
<!-- 08 May 2019 KJE: Changed name of string in en.xml                 -->
<!--                                                                   -->
<!-- ================================================================= --> 

<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                xmlns:xs="http://www.w3.org/2001/XMLSchema" 
                xmlns:fo="http://www.w3.org/1999/XSL/Format" 
                xmlns:opentopic-func="http://www.idiominc.com/opentopic/exsl/function" 
                version="2.0">
 
 <!-- VARIABLES                            --> 
 <!-- Based on metadata from root DITA map -->
 <!-- Used on cover page and in footers    -->
 
  <!-- Variable: Document title --> 
 <xsl:variable name="documentTitle">
  <xsl:value-of
   select="
   /*[contains(@class, ' bookmap/bookmap ')]/*
   /*[contains(@class, ' bookmap/booktitle ')]
   /*[contains(@class, ' bookmap/mainbooktitle ')]"
  />
 </xsl:variable>
 
  <!-- Variable: Stage of the document --> 
 <xsl:variable name="documentStage"
  select="
  /*[contains(@class, ' bookmap/bookmap ')]/*
  /*[contains(@class, ' bookmap/booktitle ')]
  /*[contains(@class, ' bookmap/booktitlealt ')][@outputclass = 'documentStage']"/>
 
 <!-- Variable: Date of the stage document --> 
 <xsl:variable name="documentDate">
  <xsl:value-of
   select="
   /*[contains(@class, ' bookmap/bookmap ')]/*
   /*[contains(@class, ' bookmap/booktitle ')]
   /*[contains(@class, ' bookmap/booktitlealt ')][@outputclass = 'stageDate']"
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
 
 <!-- Variable: Work product information -->  
 <xsl:variable name="ditaproduct">
  <xsl:call-template name="getVariable">
   <xsl:with-param name="id" select="'Committee note track'" />
  </xsl:call-template>
 </xsl:variable>

</xsl:stylesheet>

