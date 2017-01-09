<?xml version='1.0'?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                xmlns:xs="http://www.w3.org/2001/XMLSchema" 
                xmlns:fo="http://www.w3.org/1999/XSL/Format" 
                xmlns:opentopic-func="http://www.idiominc.com/opentopic/exsl/function" version="2.0">

 <!-- ===================== CHANGE LOG ================================ -->
 <!--                                                                   -->
 <!-- 05 Sep 2015 KJE: Added change log. Moved text to en.xml.          -->
 <!-- o5 Jan 2016 BT: Added cnVersion variable. Modified footers.       -->
 <!-- 31 Jan 2016 KJE: Replaced call to deprecated template             -->
 <!--                                                                   -->
 <!-- ================================================================= --> 
 
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
 
 <xsl:variable name="specLevel"
  select="
  /*[contains(@class, ' bookmap/bookmap ')]/*
  /*[contains(@class, ' bookmap/booktitle ')]
  /*[contains(@class, ' bookmap/booktitlealt ')][@outputclass = 'specificationLevel']"/>
 
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
 
 <xsl:variable name="specPrefix"
  select="
  /*[contains(@class, ' bookmap/bookmap ')]/*
  /*[contains(@class, ' bookmap/booktitle')]
  /*[contains(@class, ' bookmap/booktitlealt ')][matches(@outputclass, 'specificationPrefix')]"/>
 
 <xsl:variable name="specScope"
  select="
  /*[contains(@class, ' bookmap/bookmap ')]/*
  /*[contains(@class, ' bookmap/booktitle')]
  /*[contains(@class, ' bookmap/booktitlealt ')][matches(@outputclass, 'specificationScope')]"/>
 
 <xsl:variable name="specVersion"
  select="
  /*[contains(@class, ' bookmap/bookmap ')]/*
  /*[contains(@class, ' bookmap/bookmeta')]
  /*[contains(@class, ' topic/prodinfo ')]
  /*[contains(@class, ' topic/vrmlist ')]
  /*[contains(@class, ' topic/vrm ')]/@version"/> 
 
 <xsl:variable name="cnVersion"
  select="
   /*[contains(@class, ' bookmap/bookmap ')]/*
   /*[contains(@class, ' bookmap/bookmeta')]
   /*[contains(@class, ' bookmap/bookid ')]
   /*[contains(@class, ' bookmap/edition ')]"/>

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
 
 <!-- Variable: Work product metadata -->   
 <xsl:variable name="ditaversion">
  <xsl:text>dita-</xsl:text>
  <xsl:value-of select="$specVersion"/>
  <xsl:text>-</xsl:text>
  <xsl:value-of select="$specScope"/>
  <xsl:text>-v</xsl:text>
  <xsl:value-of select="$cnVersion"/>
  <xsl:text>-</xsl:text>
  <xsl:choose>
   <xsl:when test="($specLevel castable as xs:double) and number($specLevel) > 0">
    <xsl:value-of select="$specPrefix"/>
    <xsl:number value="number($specLevel)" format="01"/>
   </xsl:when>
   <xsl:otherwise>spec</xsl:otherwise>
  </xsl:choose>
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

