<?xml version="1.0" encoding="UTF-8" ?>
<xsl:stylesheet version="1.0"
		xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
  <xsl:output method="text" />
  <xsl:template match="/">
    <xsl:for-each select="/TiVoContainer/Item">
      <xsl:if test="contains(Details/ContentType,'video/x-tivo-raw-tts')">
	<xsl:variable name="fid">
	  <xsl:value-of select="substring-after(Links/Content/Url,'id=')" />
	</xsl:variable>
	<xsl:value-of select="$fid" />
<xsl:text>&#09;</xsl:text>
<xsl:value-of select="Details/Duration div 1000" />
<xsl:text>&#09;</xsl:text>
<xsl:value-of select="Details/Title" />
<xsl:text>&#09;</xsl:text>
<xsl:value-of select="Details/EpisodeTitle" />
<xsl:text>&#10;</xsl:text>
      </xsl:if>
    </xsl:for-each>
  </xsl:template>
</xsl:stylesheet>
