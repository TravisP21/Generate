﻿using System;
using System.Collections.Generic;

namespace generate.core.Models.Staging
{
    public partial class ProgramParticipationTitleI
    {
        public int ID { get; set; }
        public string StudentIdentifierState { get; set; }
        public string LeaIdentifierSeaAccountability { get; set; }
        public string LeaIdentifierSeaAttendance { get; set; }
        public string LeaIdentifierSeaFunding { get; set; }
        public string LeaIdentifierSeaGraduation { get; set; }
        public string LeaIdentifierSeaIndividualizedEducationProgram { get; set; }
        public string SchoolIdentifierSea { get; set; }
        public Boolean ResponsibleSchoolTypeAccountability { get; set; }
        public Boolean ResponsibleSchoolTypeAttendance { get; set; }
        public Boolean ResponsibleSchoolTypeFunding { get; set; }
        public Boolean ResponsibleSchoolTypeGraduation { get; set; }
        public Boolean ResponsibleSchoolTypeIndividualizedEducationProgram { get; set; }
        public Boolean ResponsibleSchoolTypeTransportation { get; set; }
        public Boolean ResponsibleSchoolTypeIepServiceProvider { get; set; }
        public string TitleIIndicator { get; set; }
        public string DataCollectionName { get; set; }
        //public int? PersonID { get; set; }
        //public int? RefTitleIIndicatorId { get; set; }
        //public int? OrganizationID_LEA { get; set; }
        //public int? OrganizationID_School { get; set; }
        //public int? LEAOrganizationPersonRoleID_TitleIProgram { get; set; }
        //public int? LEAOrganizationID_TitleIProgram { get; set; }
        //public int? LEAPersonProgramParticipationId { get; set; }
        //public int? SchoolOrganizationID_TitleIProgram { get; set; }
        //public int? SchoolOrganizationPersonRoleID_TitleIProgram { get; set; }
        //public int? SchoolPersonProgramParticipationId { get; set; }
        public DateTime? RunDateTime { get; set; }
        public DateTime? ProgramParticipationBeginDate { get; set; }
        public DateTime? ProgramParticipationEndDate { get; set; }
    }
}