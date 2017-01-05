<?xml version="1.0" encoding="UTF-8"?>
<!--
This file is part of the DITA Open Toolkit project.

Copyright 2014 Jarno Elovirta

See the accompanying LICENSE file for applicable license.
-->
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
  xmlns:fo="http://www.w3.org/1999/XSL/Format" version="2.0">

  <xsl:attribute-set name="__xml-mention" use-attribute-sets="__inline__monospace"/>

  <xsl:attribute-set name="xmlelement" use-attribute-sets="__xml-mention"/>

  <xsl:attribute-set name="xmlatt" use-attribute-sets="__xml-mention"/>

  <xsl:attribute-set name="textentity" use-attribute-sets="__xml-mention"/>

  <xsl:attribute-set name="parameterentity" use-attribute-sets="__xml-mention"/>

  <xsl:attribute-set name="numcharref" use-attribute-sets="__xml-mention"/>

  <xsl:attribute-set name="xmlnsname" use-attribute-sets="__xml-mention"/>

  <xsl:attribute-set name="xmlpi" use-attribute-sets="__xml-mention"/>

</xsl:stylesheet>
