﻿using System;
using System.Collections.Generic;

namespace generate.core.Models.IDS
{
    public partial class RefPsEnrollmentAwardType
    {
        public RefPsEnrollmentAwardType()
        {
            PsStudentEnrollment = new HashSet<PsStudentEnrollment>();
        }

        public int RefPsEnrollmentAwardTypeId { get; set; }
        public string Description { get; set; }
        public string Code { get; set; }
        public string Definition { get; set; }
        public int? RefJurisdictionId { get; set; }
        public decimal? SortOrder { get; set; }

        public virtual ICollection<PsStudentEnrollment> PsStudentEnrollment { get; set; }
        public virtual Organization RefJurisdiction { get; set; }
    }
}