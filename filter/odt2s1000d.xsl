<?xml version='1.0' encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
    xmlns:text="urn:oasis:names:tc:opendocument:xmlns:text:1.0"
    xmlns:office="urn:oasis:names:tc:opendocument:xmlns:office:1.0"
    xmlns:xsl="http://www.w3.org/1999/XSL/Transform" exclude-result-prefixes="office text">
    <xsl:output method="xml" indent="yes" version="1.0" encoding="UTF-8"/>

    <xsl:variable name="whitespace" select="'&#09;&#10;&#13; '"/>

    <!-- Strips trailing whitespace characters from 'string' -->
    <xsl:template name="string-rtrim">
        <xsl:param name="string"/>
        <xsl:param name="trim" select="$whitespace"/>

        <xsl:variable name="length" select="string-length($string)"/>

        <xsl:if test="$length &gt; 0">
            <xsl:choose>
                <xsl:when test="contains($trim, substring($string, $length, 1))">
                    <xsl:call-template name="string-rtrim">
                        <xsl:with-param name="string" select="substring($string, 1, $length - 1)"/>
                        <xsl:with-param name="trim" select="$trim"/>
                    </xsl:call-template>
                </xsl:when>
                <xsl:otherwise>
                    <xsl:value-of select="$string"/>
                </xsl:otherwise>
            </xsl:choose>
        </xsl:if>
    </xsl:template>

    <!-- Strips leading whitespace characters from 'string' -->
    <xsl:template name="string-ltrim">
        <xsl:param name="string"/>
        <xsl:param name="trim" select="$whitespace"/>

        <xsl:if test="string-length($string) &gt; 0">
            <xsl:choose>
                <xsl:when test="contains($trim, substring($string, 1, 1))">
                    <xsl:call-template name="string-ltrim">
                        <xsl:with-param name="string" select="substring($string, 2)"/>
                        <xsl:with-param name="trim" select="$trim"/>
                    </xsl:call-template>
                </xsl:when>
                <xsl:otherwise>
                    <xsl:value-of select="$string"/>
                </xsl:otherwise>
            </xsl:choose>
        </xsl:if>
    </xsl:template>

    <!-- Strips leading and trailing whitespace characters from 'string' -->
    <xsl:template name="string-trim">
        <xsl:param name="string"/>
        <xsl:param name="trim" select="$whitespace"/>
        <xsl:call-template name="string-rtrim">
            <xsl:with-param name="string">
                <xsl:call-template name="string-ltrim">
                    <xsl:with-param name="string" select="$string"/>
                    <xsl:with-param name="trim" select="$trim"/>
                </xsl:call-template>
            </xsl:with-param>
            <xsl:with-param name="trim" select="$trim"/>
        </xsl:call-template>
    </xsl:template>


    <!-- START -->
    <xsl:template match="/*">
        <xsl:message>Start!</xsl:message>
        <xsl:comment>
	         <xsl:value-of select="name(.)"/>
	    </xsl:comment>
        <xsl:element name="dmodule">

            <xsl:attribute name="xsi:noNamespaceSchemaLocation"
                >http://www.s1000d.org/S1000D_4-0-1/xml_schema_flat/descript.xsd</xsl:attribute>
            <identAndStatusSection>
                <dmAddress>
                    <dmIdent>
                        <dmCode modelIdentCode="S1000DXSL" systemDiffCode="A" systemCode="00"
                            subSystemCode="0" subSubSystemCode="0" assyCode="00" disassyCode="00"
                            disassyCodeVariant="A" infoCode="040" infoCodeVariant="A"
                            itemLocationCode="A"/>
                        <language languageIsoCode="en" countryIsoCode="GB"/>
                        <issueInfo issueNumber="001" inWork="01"/>
                    </dmIdent>
                    <dmAddressItems>
                        <issueDate year="2011" month="01" day="30"/>
                        <dmTitle>
                            <techName>S1000D XSL Stylesheets</techName>
                            <infoName>README</infoName>
                        </dmTitle>
                    </dmAddressItems>
                </dmAddress>
                <dmStatus issueType="changed">
                    <security securityClassification="01"/>
                    <responsiblePartnerCompany>
                        <enterpriseName>АО "НТЦ РЭБ"</enterpriseName>
                    </responsiblePartnerCompany>
                    <originator>
                        <enterpriseName>АО "НТЦ РЭБ"</enterpriseName>
                    </originator>
                    <applic>
                        <displayText>
                            <simplePara>Все</simplePara>
                        </displayText>
                    </applic>
                    <brexDmRef>
                        <dmRef>
                            <dmRefIdent>
                                <!-- default BREX -->
                                <dmCode modelIdentCode="S1000D" systemDiffCode="A" systemCode="04"
                                    subSystemCode="1" subSubSystemCode="0" assyCode="0301"
                                    disassyCode="00" disassyCodeVariant="A" infoCode="022"
                                    infoCodeVariant="A" itemLocationCode="D"/>
                            </dmRefIdent>
                        </dmRef>
                    </brexDmRef>
                    <qualityAssurance>
                        <unverified/>
                    </qualityAssurance>
                </dmStatus>
            </identAndStatusSection>
            <content>
                <description>
                    <xsl:apply-templates select="office:body"/>
                </description>
            </content>


        </xsl:element>
    </xsl:template>




    <xsl:template match="office:body">
        <xsl:message>Body!</xsl:message>
        <xsl:apply-templates/>
    </xsl:template>

    <xsl:template match="office:text">
        <xsl:apply-templates/>
    </xsl:template>

    <xsl:template match="text:p">
        <xsl:if test="string-length(normalize-space(.)) &gt; 1">
            <para>
                <xsl:value-of select="normalize-space(.)"/>
            </para>
        </xsl:if>
    </xsl:template>
    <xsl:template match="*"/>


</xsl:stylesheet>
