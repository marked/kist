<?xml version="1.0" encoding="UTF-8" ?>
<xsl:stylesheet version="1.0"
xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
  
  <xsl:template match="/">
    <rss version="2.0">
      <channel>
	<title>
	  <xsl:value-of select="/TiVoContainer/Details/Title" />
	</title>
	<xsl:value-of select="catalog/cd/title"/>
	<xsl:for-each select="/TiVoContainer/Item">
	  <xsl:if test="contains(Details/ContentType,'video/x-tivo-raw-tts')">
	    <item>
	      <title>
		<b><xsl:value-of select="Details/Title" /></b>
	      </title>
	      <description>
		<xsl:value-of select="Details/Description" />
	      </description>
	      <xsl:variable name="fid">
		<xsl:for-each select="Links/Content/Url">
		  <xsl:value-of select="substring-after(current(),'id=')" />
		</xsl:for-each>
	      </xsl:variable>
	      <link>
		<a href="{$fid}.mpg"> Play
		</a>
	      </link>
	    </item>
	  </xsl:if>
	</xsl:for-each>
      </channel>
    </rss>
  </xsl:template>
</xsl:stylesheet>
