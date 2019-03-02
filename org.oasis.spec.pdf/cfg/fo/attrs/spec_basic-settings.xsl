<?xml version='1.0' encoding='utf-8'?>

<!-- ===================== CHANGE LOG ================================ -->
<!--                                                                   -->
<!-- 08 Feb 2019 KJE: Added change log. Replaced OASIS cover color     -->
<!-- 02 Mar 2019 KJE: Changed color for table header row.              -->
<!--                                                                   -->
<!-- ================================================================= --> 

<xsl:stylesheet exclude-result-prefixes="xs ditaarch opentopic spdf" version="2.0"
                xmlns:ditaarch="http://dita.oasis-open.org/architecture/2005/"
                xmlns:spdf="org.oasis.spec.pdf" 
                xmlns:opentopic="http://www.idiominc.com/opentopic"
                xmlns:opentopic-func="http://www.idiominc.com/opentopic/exsl/function"
                xmlns:xs="http://www.w3.org/2001/XMLSchema" 
                xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
  
  <xsl:param name="pdfFormatter" select="'ah'"/>
  <xsl:param name="tocMaximumLevel" select="6"/>
  <xsl:param name="outputfilebasename">dita-v1.3-errata01-os-part0-overview-complete</xsl:param>
  
  <xsl:variable name="page-width">215.9mm</xsl:variable>
  <xsl:variable name="page-height">279.4mm</xsl:variable>
  <xsl:variable name="mirror-page-margins" select="false()"/>
  
  <xsl:variable name="page-margin-top">26mm</xsl:variable>
  
  <xsl:variable name="side-col-width">0pt</xsl:variable>
  
  <xsl:variable name="default-font-size">10pt</xsl:variable>
  <xsl:variable name="small-font-size">9.5pt</xsl:variable>
  <xsl:variable name="default-monospace-size">9.5pt</xsl:variable>
  <xsl:variable name="small-monospace-size">8.5pt</xsl:variable>
  <xsl:variable name="default-line-height">1.3</xsl:variable>
  
  <!--<xsl:variable name="body-heading-color">#3B006F</xsl:variable>-->
  <xsl:variable name="body-heading-color">#446CAA</xsl:variable>
  <!--<xsl:variable name="cover-heading-color">#3B006F</xsl:variable>-->
  <xsl:variable name="cover-heading-color">#446CAA</xsl:variable>
  <xsl:variable name="text-color">#000000</xsl:variable>
  <xsl:variable name="tableHeaderCellHighlightBGColor">#edf1f8</xsl:variable>
  
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
  
  <xsl:variable name="oasis-date">
    <xsl:value-of
      select="
      /*[contains(@class, ' bookmap/bookmap ')]/*
      /*[contains(@class, ' bookmap/booktitle ')]
      /*[contains(@class, ' bookmap/booktitlealt ')][@outputclass = 'specificationApproved']"
    />
  </xsl:variable>
  
  <xsl:variable name="ditaversion">
    <xsl:value-of select="$outputfilebasename"/>
  </xsl:variable>
  
  <xsl:variable name="ditaproduct">
    <xsl:text>Standards Track Work Product</xsl:text>
  </xsl:variable>
  
  <!--<xsl:variable name="common-list-margin">4pt</xsl:variable>
  <xsl:variable name="common-list-margin-table">1pt</xsl:variable>-->
  
</xsl:stylesheet>
